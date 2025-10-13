return {
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = '<leader>R',
      ui = {
        default_winbar_panes = { 'body', 'headers', 'verbose', 'script_output', 'stats', 'report' },
        show_variable_info_text = "float",
      },
    },
    keys = {
      {
        '<leader>Rb',
        function()
          require('kulala').scratchpad()
        end,
        desc = 'Open scratchpad',
      },
    },
  },
}
