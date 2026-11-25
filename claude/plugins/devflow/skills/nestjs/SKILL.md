---
name: nestjs
description: NestJS specifics for bugfixes, covering modules, providers, DI and repositories. Loaded by the fix skill when the project uses NestJS. Use whenever editing NestJS modules, providers or data access.
---

# NestJS conventions

Applies when `package.json` has `@nestjs/*` dependencies. These are the NestJS forms of the generic rules in the `fix` skill. Check the project's existing code first. If it already has a pattern for something below, follow the project, not this file.

## Modules and providers

- A provider belongs to exactly one module. Never list it in another module's `providers` array.
- To share it: add it to `exports` of the owning module, add that module to `imports` where it is needed.
- Re-exporting is allowed when a module exists only to aggregate others (`exports: [OtherModule]`).
- Circular module imports: `imports: [forwardRef(() => OtherModule)]` on both sides. Circular providers: `@Inject(forwardRef(() => OtherService))` in the constructor. Before using it, check whether the cycle can be removed by moving shared logic to a third provider or by emitting an event. Prefer removing the cycle.
- Never use `ModuleRef.get` or `ModuleRef.resolve` to fetch providers. Inject through the constructor.
- Lazy injection: if the project already has a lazy injection mechanism, use it. Do not invent one.

## Repositories

- One dedicated repository class per model, an `@Injectable()` provider, registered and exported by the module that owns the model. Follow the existing repositories for the shape (extends the ORM repository or wraps it).
- Services and controllers get it through the constructor. They do not receive `EntityManager`, `DataSource` or ORM repositories directly for their own data access.
- If the project uses TypeORM, a module that provides a repository for an entity needs `TypeOrmModule.forFeature([Entity])` in its `imports`. Other modules then import the owning module and do not repeat `forFeature` for that entity. Verify the ORM in `package.json` before relying on this.
- Queries live in repository methods. Inside a custom repository, use `this`, not a threaded manager, unless the method takes part in a caller's transaction.
- Transactions: follow the project's pattern. If other services pass the `EntityManager` into repository methods, do the same and call the manager's own method directly. No wrapper helpers like `runInTransaction`.

## Checklist before finishing

1. Every module file touched: no foreign provider in `providers`, needed ones exported and imported.
2. Every class touched: no `EntityManager`, `getRepository`, `DataSource.getRepository` or `ModuleRef.get` used for its own data access.
3. New repository: registered in its owning module and exported.
4. App boots: run the project's build or start command and check for Nest DI errors such as "Nest can't resolve dependencies of ...".
