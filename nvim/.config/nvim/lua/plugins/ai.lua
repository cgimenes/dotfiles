-- Copilot
vim.pack.add { 'https://github.com/zbirenbaum/copilot.lua' }
BuildAfterUpdate('copilot.lua', ':Copilot auth')
require('copilot').setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}

-- Sidekick
vim.pack.add { 'https://github.com/folke/sidekick.nvim' }
require('sidekick').setup {
  nes = {
    enabled = false,
  },
  cli = {
    mux = {
      backend = 'tmux',
      enabled = true,
    },
    prompts = {
      refinement = [[
Sou um arquiteto de software, estou refinando uma tarefa desse projeto e gostaria de formatá-la com 
as seguintes seções: Objetivo, Descrição, Passos chave, Considerações técnicas e Definition of Done.
Descreva melhor a minha tarefa com base na seguinte entrada e nas seções mencionadas.
Leve em consideração o padrão arquitetural e de código do projeto.
A tarefa está no arquivo TASK.md. Ao final, pode substituir o conteúdo do arquivo TASK.md com a 
nova tarefa formatada, mas sem incluir no Git.
]],
      vscode_instructions = [[
Analyze this codebase to generate or update .github/copilot-instructions.md for guiding AI coding agents.

Focus on discovering the essential knowledge that would help an AI agents be immediately productive in this codebase. Consider aspects like:

The "big picture" architecture that requires reading multiple files to understand - major components, service boundaries, data flows, and the "why" behind structural decisions
Critical developer workflows (builds, tests, debugging) especially commands that aren't obvious from file inspection alone
Project-specific conventions and patterns that differ from common practices
Integration points, external dependencies, and cross-component communication patterns
Do one glob search to source existing AI conventions from .github/copilot-instructions.md,AGENT.md,AGENTS.md,CLAUDE.md,.cursorrules,.windsurfrules,.clinerules,.cursor/rules/**,.windsurf/rules/**,.clinerules/**,README.md

Guidelines (read more at https://aka.ms/vscode-instructions-docs):

If .github/copilot-instructions.md exists, merge intelligently - preserve valuable content while updating outdated sections
Write concise, actionable instructions (~20-50 lines) using markdown structure
Include specific examples from the codebase when describing patterns
Avoid generic advice ("write tests", "handle errors") - focus on THIS project's specific approaches
Document only discoverable patterns, not aspirational practices
Reference key files/directories that exemplify important patterns
Update .github/copilot-instructions.md for the user, then ask for feedback on any unclear or incomplete sections to iterate.
]],
      copilot_instructions = [[
Your task is to "onboard" this repository to Copilot coding agent by adding a .github/copilot-instructions.md file in the repository that contains information describing how a coding agent seeing it for the first time can work most efficiently.

You will do this task only one time per repository and doing a good job can SIGNIFICANTLY improve the quality of the agent's work, so take your time, think carefully, and search thoroughly before writing the instructions.

<Goals>
- Reduce the likelihood of a coding agent pull request getting rejected by the user due to
generating code that fails the continuous integration build, fails a validation pipeline, or
having misbehavior.
- Minimize bash command and build failures.
- Allow the agent to complete its task more quickly by minimizing the need for exploration using grep, find, str_replace_editor, and code search tools.
</Goals>

<Limitations>
- Instructions must be no longer than 2 pages.
- Instructions must not be task specific.
</Limitations>

<WhatToAdd>

Add the following high level details about the codebase to reduce the amount of searching the agent has to do to understand the codebase each time:
<HighLevelDetails>

- A summary of what the repository does.
- High level repository information, such as the size of the repo, the type of the project, the languages, frameworks, or target runtimes in use.
</HighLevelDetails>

Add information about how to build and validate changes so the agent does not need to search and find it each time.
<BuildInstructions>

- For each of bootstrap, build, test, run, lint, and any other scripted step, document the sequence of steps to take to run it successfully as well as the versions of any runtime or build tools used.
- Each command should be validated by running it to ensure that it works correctly as well as any preconditions and postconditions.
- Try cleaning the repo and environment and running commands in different orders and document errors and and misbehavior observed as well as any steps used to mitigate the problem.
- Run the tests and document the order of steps required to run the tests.
- Make a change to the codebase. Document any unexpected build issues as well as the workarounds.
- Document environment setup steps that seem optional but that you have validated are actually required.
- Document the time required for commands that failed due to timing out.
- When you find a sequence of commands that work for a particular purpose, document them in detail.
- Use language to indicate when something should always be done. For example: "always run npm install before building".
- Record any validation steps from documentation.
</BuildInstructions>

List key facts about the layout and architecture of the codebase to help the agent find where to make changes with minimal searching.
<ProjectLayout>

- A description of the major architectural elements of the project, including the relative paths to the main project files, the location
of configuration files for linting, compilation, testing, and preferences.
- A description of the checks run prior to check in, including any GitHub workflows, continuous integration builds, or other validation pipelines.
- Document the steps so that the agent can replicate these itself.
- Any explicit validation steps that the agent can consider to have further confidence in its changes.
- Dependencies that aren't obvious from the layout or file structure.
- Finally, fill in any remaining space with detailed lists of the following, in order of priority: the list of files in the repo root, the
contents of the README, the contents of any key source files, the list of files in the next level down of directories, giving priority to the more structurally important and snippets of code from key source files, such as the one containing the main method.
</ProjectLayout>
</WhatToAdd>

<StepsToFollow>
- Perform a comprehensive inventory of the codebase. Search for and view:
- README.md, CONTRIBUTING.md, and all other documentation files.
- Search the codebase for build steps and indications of workarounds like 'HACK', 'TODO', etc.
- All scripts, particularly those pertaining to build and repo or environment setup.
- All build and actions pipelines.
- All project files.
- All configuration and linting files.
- For each file:
- think: are the contents or the existence of the file information that the coding agent will need to implement, build, test, validate, or demo a code change?
- If yes:
   - Document the command or information in detail.
   - Explicitly indicate which commands work and which do not and the order in which commands should be run.
   - Document any errors encountered as well as the steps taken to workaround them.
- Document any other steps or information that the agent can use to reduce time spent exploring or trying and failing to run bash commands.
- Finally, explicitly instruct the agent to trust the instructions and only perform a search if the information in the instructions is incomplete or found to be in error.
</StepsToFollow>
   - Document any errors encountered as well as the steps taken to work-around them.
]],
      task = [[
A partir de agora, aja como um desenvolvedor sênior especializado em arquitetura e qualidade de código.
Seu objetivo é **gerar código robusto, seguro e fácil de manter**, com foco em **clareza, cobertura de testes e consistência de padrões**.
Siga estas diretrizes sempre que produzir código, testes ou instruções de implementação:
1. **Valide requisitos e suposições antes de gerar código.**
   → Se algo estiver ambíguo, pergunte antes de prosseguir.
2. **Explique brevemente o raciocínio técnico** por trás das escolhas (ex: design de classes, dependências, estratégias de teste).
3. **Garanta padrões de qualidade:**
   * Nomeação clara e consistente.
   * Tratamento de erros explícito.
   * Zero duplicação de lógica.
4. **Para testes automatizados:**
   * Sempre incluir testes positivos, negativos e de borda.
   * Simular dependências (mocks/stubs/spies) quando apropriado.
   * Verificar mensagens de erro e status codes, não só resultados.
   * Explicar brevemente o propósito de cada teste.
5. **Nunca gerar código parcial** — toda função, módulo ou teste deve ser funcional, ainda que simplificado.
6. **Adote mindset de PR review:**
   * Questione riscos de segurança, concorrência ou inconsistência.
   * Comente potenciais melhorias e edge cases.
7. **Adapte-se ao contexto do projeto** (framework, linguagem, padrões já existentes).
8. **Valide o fluxo de ponta a ponta mentalmente** antes de entregar — verifique se o código realmente faz o que o requisito pede.
   Ao responder, mantenha o tom de **um engenheiro experiente revisando código**, nunca apenas gerando texto.

Analise todo o projeto antes de iniciar a implementação.
* Respeite o padrão de código, arquitetura e boas práticas já adotados no projeto.
* Implemente a task descrita abaixo, garantindo que:
    1. A solução seja consistente com o estilo e padrões existentes.
    2. O código seja limpo, legível e documentado quando necessário.
    3. Testes adequados sejam criados ou atualizados, conforme aplicável.
    4. A entrega atenda integralmente aos requisitos listados na tarefa.

Tarefa:
]],
    },
  },
}
Map {
  '<c-n>',
  function()
    -- if there is a next edit, jump to it, otherwise apply it if any
    if not require('sidekick').nes_jump_or_apply() then
      return '<Tab>' -- fallback to normal tab
    end
  end,
  expr = true,
  desc = 'Goto/Apply Next Edit Suggestion',
}
Map {
  '<leader>on',
  function()
    require('sidekick.nes').toggle()
  end,
  desc = 'Toggle Sidekick NES',
}
Map {
  '<leader>aa',
  function()
    require('sidekick.cli').toggle { name = 'copilot' }
  end,
  desc = 'Sidekick Toggle CLI',
}
Map {
  '<leader>at',
  function()
    require('sidekick.cli').send { msg = '{this}' }
  end,
  mode = { 'x', 'n' },
  desc = 'Sidekick Send This',
}
Map {
  '<leader>af',
  function()
    require('sidekick.cli').send { msg = '{file}' }
  end,
  desc = 'Sidekick Send File',
}
Map {
  '<leader>av',
  function()
    require('sidekick.cli').send { msg = '{selection}' }
  end,
  mode = { 'x' },
  desc = 'Sidekick Send Visual Selection',
}
Map {
  '<leader>ap',
  function()
    require('sidekick.cli').prompt()
  end,
  mode = { 'n', 'x' },
  desc = 'Sidekick Select Prompt',
}
