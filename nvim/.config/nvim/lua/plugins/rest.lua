return {
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    opts = {
      global_keymaps = false,
      ui = {
        default_winbar_panes = { 'body', 'headers', 'verbose', 'script_output', 'stats', 'report' },
      },
    },
    keys = {
      {
        '<leader>Ra',
        function()
          require('kulala').run_all()
        end,
        desc = 'Send all requests',
      },
      {
        '<leader>Rb',
        function()
          require('kulala').scratchpad()
        end,
        desc = 'Open scratchpad',
      },
      {
        '<leader>Rc',
        function()
          require('kulala').copy()
        end,
        ft = { 'http', 'rest' },
        desc = 'Copy as cURL',
      },
      {
        '<leader>RC',
        function()
          require('kulala').from_curl()
        end,
        ft = { 'http', 'rest' },
        desc = 'Paste from curl',
      },
      {
        '<CR>',
        function()
          require('kulala').run()
        end,
        mode = { 'n', 'v' },
        ft = { 'http', 'rest' },
        desc = 'Send request <cr>',
      },
      {
        '<leader>Rf',
        function()
          require('kulala').search()
        end,
        ft = { 'http', 'rest' },
        desc = 'Find request',
      },
      {
        '<leader>Rg',
        function()
          require('kulala').download_graphql_schema()
        end,
        ft = { 'http', 'rest' },
        desc = 'Download GraphQL schema',
      },
      {
        '<leader>Rx',
        function()
          require('kulala').scripts_clear_global()
        end,
        ft = { 'http', 'rest' },
        desc = 'Clear globals',
      },
      {
        '<leader>RX',
        function()
          require('kulala').clear_cached_files()
        end,
        ft = { 'http', 'rest' },
        desc = 'Clear cached files',
      },
    },
  },
}
