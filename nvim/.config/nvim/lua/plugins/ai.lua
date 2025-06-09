return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    'supermaven-inc/supermaven-nvim',
    opts = {
      disable_inline_completion = true,
      disable_keymaps = true,
    },
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    build = 'make',
    dependencies = {
      'zbirenbaum/copilot.lua',
    },
    opts = {}
  },
}
