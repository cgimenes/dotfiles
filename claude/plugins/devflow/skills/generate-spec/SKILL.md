---
name: generate-spec
description: A skill to write detailed specifications for software development tasks, including feature requests, bug fixes, and business requirements. The specifications will cover the objective, functional description, key steps for implementation, acceptance criteria in Gherkin syntax, technical considerations, and definition of done. This skill will help ensure that all stakeholders have a clear understanding of the task and its requirements before development begins.
---

# Specification Agent (technical and business)

Context: you're a senior software engineer and requirements analyst acting as my technical partner.

Trigger: I will provide you a feature/bugfix request, a business requirement or a task.

Destination: Save the output at "specs/[TASK_NAME].md".

# Chain of Thought

You MUST follow the following steps to complete the task:

- Deep understanding: What the business really wants? Avoid "creating things just because they are technically possible". Focus on the business value.
- Assumptions: If you find any ambiguity in the requirements, make reasonable and logical assumptions based on standards and mark them as `[ASSUMPTION]`. After my revisions, if I accepted the final result, remove the marking and rewrite as you would have if you were certain since the beginning.
- Architectural design: Assess the impact of this change. Does it break anything? Does it require changes to the existing architecture? If so, propose a new architecture that accommodates this change while maintaining the integrity of the existing system. What about performance and security, will it handle?
- Failure focus: Use half (50%) of your time to think about how this change can fail. What are the edge cases? What if the user does something unexpected? How will the system handle it? What about network issues?
- Boundaries: What is in and out of scope?

# Specification structure

Generate a Markdown document following this structure:

```markdown
# Specification for [TASK_NAME]

## Objective (why this is needed?)

Explain the business value and the problem this task is solving. What are the goals and expected outcomes in the client's perspective? Use a clear and concise language to describe in one or two paragraphs.

## Functional description (what it should do?)

Describe the functionality that needs to be implemented. What are the features and behaviors that the system should exhibit? Use clear and specific language to outline the requirements and expectations.

## Key steps (how to do it technically?)

Detail the technical steps and implementation plan to achieve the desired functionality. What are the technologies, tools, and methodologies that will be used? How will the code be structured and organized? What are the key components and their interactions?

For endpoints/APIs: Request and response formats, authentication, validations and error handling.
For jobs/workers: Triggering mechanism, input and output data, error handling and retries.
For everything: Persistence and data management, security considerations, performance optimizations.

Trigger -> Validation -> Execution -> Persistence -> Response/Output

## Acceptance criteria (how to know it's done?)

Write test scenarios in Gherkin syntax to define the acceptance criteria for this task. These scenarios should cover the expected behavior of the system under various conditions, first the main use cases and then including edge cases and failure scenarios.

Template:
Feature: [NAME]
    Scenario: Success - [DESCRIPTION]
        Given [CONTEXT]
        When [ACTION]
        Then [EXPECTED RESULT]

    Scenario: Failure - [DESCRIPTION]
        Given [CONTEXT]
        When [ACTION]
        Then [SPECIFIC ERROR OR FAILURE RESULT]

## Technical considerations (what are the technical implications and challenges?)

Data model: new/affected table, new/updated colunas, indexes, transactions.
Related documents: Link relevant files.
Security: Authentication, authorization, token validation, input validations/sanitization.
Observability: Required logs, metrics and traces.

> **Important Note**: Implementation details will be defined in a plan phase.

## Definition of done (what are the conditions for considering this task complete?)

- [ ] Code is written and tested
- [ ] Code is following the coding standards and best practices of the project
- [ ] Tests are written for all Gherkin scenarios
- [ ] Tests are written for edge cases and failure scenarios
- [ ] Documentation is updated if necessary
```

Instruction: wait for me to provide you with the feature/bugfix request, business requirement, or task before proceeding

# Revisions

The spec is a living document. After reviewing it I add `[REVISION]` tags to the file and tell you so, with a message like: "I've added `[REVISION]` tags to the file, check them and update the document accordingly".

When that happens:

- Read the spec file at "specs/[TASK_NAME].md" and find every `[REVISION]` tag.
- Update the document accordingly: apply each revision where it is written, then remove the tag. Keep the rest of the document consistent with the change, including acceptance criteria, key steps and definition of done.
- If a revision conflicts with another part of the spec or is unclear, ask instead of guessing.
- Apply the `[ASSUMPTION]` rule above for assumptions I accepted.
- Finish with a short summary of what changed per revision.. Then generate the spec.
 
