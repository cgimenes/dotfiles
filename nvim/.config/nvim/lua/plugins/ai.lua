return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept = '<M-y>',
        },
      },
      panel = { enabled = false },
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
    opts = {
      provider = 'copilot',
      vendors = {
        ['copilot/claude-opus-4'] = {
          __inherited_from = 'copilot',
          model = 'claude-opus-4',
          display_name = 'copilot/claude-opus-4',
          max_tokens = 80000,
        },
      },
    },
  },
}
