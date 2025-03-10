return {
  {
    'vim-test/vim-test',
    cmd = 'TestSuite',
    dependencies = {
      'preservim/vimux',
    },
    config = function()
      vim.cmd "let test#strategy = 'vimux'"
      vim.cmd "let test#echo_command = 0"
      vim.g.VimuxCloseOnExit = 1
    end,
    keys = {
      { '<leader>tn', '<cmd>silent! wa<cr><cmd>TestNearest<cr>', desc = '[T]est [N]earest' },
      { '<leader>tf', '<cmd>silent! wa<cr><cmd>TestFile<cr>', desc = '[T]est [F]ile' },
      { '<leader>ts', '<cmd>silent! wa<cr><cmd>TestSuite<cr>', desc = '[T]est [S]uite' },
      { '<leader>tl', '<cmd>silent! wa<cr><cmd>TestLast<cr>', desc = '[T]est [L]ast' },
      { '<leader>tq', '<cmd>VimuxCloseRunner<cr>', desc = '[T]est [Q]uit' },
    },
  },
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'olimorris/neotest-phpunit',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        output = {
          open_on_run = true,
        },
        adapters = {
          require 'neotest-phpunit' {
            filter_dirs = { '.git', 'node_modules', 'vendor' },
          },
          require 'neotest-python' {
            dap = { justMyCode = false },
          },
        },
        summary = {
          animated = false,
        },
        icons = {
          expanded = '',
          child_prefix = '',
          child_indent = '',
          final_child_prefix = '',
          non_collapsible = '',
          collapsed = '',

          passed = '',
          running = '',
          failed = '',
          unknown = '',
        },
      }
    end,
    keys = {
      {
        '<leader>tN',
        function()
          vim.api.nvim_command 'silent! wa'
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug Nearest',
      },
      {
        '<leader>tL',
        function()
          vim.api.nvim_command 'silent! wa'
          require('neotest').run.run_last { strategy = 'dap' }
        end,
        desc = 'Debug Last',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = 'Show Output',
      },
    },
  },
}
