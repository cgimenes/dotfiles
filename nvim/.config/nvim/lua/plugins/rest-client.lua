return {
  {
    'mistweaverco/kulala.nvim',
    opts = {
      winbar = true,
      default_winbar_panes = { 'body', 'headers', 'headers_body', 'script_output', 'stats' },
    },
    ft = 'http',
    keys = {
      {
        '<leader>Rs',
        function()
          require('kulala').scratchpad()
        end,
        desc = '[S]cratchpad',
      },
      {
        '<leader>Rr',
        function()
          require('kulala').replay()
        end,
        desc = '[R]eplay last request',
      },
    },
  },
}
