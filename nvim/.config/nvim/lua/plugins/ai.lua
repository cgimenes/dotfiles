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
      copilot_instructions = [[
Analyze this codebase to generate or update .github/copilot-instructions.md for guiding AI coding agents.

Focus on discovering the essential knowledge that would help an AI agents be immediately productive in this codebase. Consider aspects like:

The "big picture" architecture that requires reading multiple files to understand - major components, service boundaries, data flows, and the "why" behind structural decisions
Critical developer workflows (builds, tests, debugging) especially commands that aren't obvious from file inspection alone
Project-specific conventions and patterns that differ from common practices
Integration points, external dependencies, and cross-component communication patterns
Source existing AI conventions from **/{.github/copilot-instructions.md,AGENT.md,AGENTS.md,CLAUDE.md,.cursorrules,.windsurfrules,.clinerules,.cursor/rules/**,.windsurf/rules/**,.clinerules/**,README.md} (do one glob search).

Guidelines (read more at https://aka.ms/vscode-instructions-docs):

If .github/copilot-instructions.md exists, merge intelligently - preserve valuable content while updating outdated sections
Write concise, actionable instructions (~20-50 lines) using markdown structure
Include specific examples from the codebase when describing patterns
Avoid generic advice ("write tests", "handle errors") - focus on THIS project's specific approaches
Document only discoverable patterns, not aspirational practices
Reference key files/directories that exemplify important patterns
Update .github/copilot-instructions.md for the user, then ask for feedback on any unclear or incomplete sections to iterate.
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
