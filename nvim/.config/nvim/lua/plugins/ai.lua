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
    event = 'InsertEnter',
    opts = {
      disable_inline_completion = true,
      disable_keymaps = true,
    },
  },
  {
    'yetone/avante.nvim',
    enabled = false,
    event = 'VeryLazy',
    version = false,
    build = 'make',
    dependencies = {
      'zbirenbaum/copilot.lua',
    },
    opts = {}
  },
  {
    'NickvanDyke/opencode.nvim',
    event = 'VeryLazy',
    dependencies = {
      'folke/snacks.nvim',
    },
    ---@type opencode.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { '<leader>at', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', },
      { '<leader>aa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = 'n', },
      { '<leader>aa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
      { '<leader>ap', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
      { '<leader>an', function() require('opencode').command('session_new') end, desc = 'New session', },
      { '<leader>ay', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
      { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up', },
      { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
    },
  },
}
