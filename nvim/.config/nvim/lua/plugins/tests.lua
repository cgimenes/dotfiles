return {
  {
    'vim-test/vim-test',
    dependencies = {
      'preservim/vimux',
    },
    config = function()
      vim.cmd "let test#strategy = 'vimux'"
      vim.g.VimuxCloseOnExit = 1
    end,
    keys = {
      { '<leader>tn', '<cmd>wa<cr><cmd>TestNearest<cr>', desc = '[T]est [N]earest' },
      { '<leader>tf', '<cmd>wa<cr><cmd>TestFile<cr>', desc = '[T]est [F]ile' },
      { '<leader>ts', '<cmd>wa<cr><cmd>TestSuite<cr>', desc = '[T]est [S]uite' },
      { '<leader>tl', '<cmd>wa<cr><cmd>TestLast<cr>', desc = '[T]est [L]ast' },
      {
        '<leader>tv',
        function()
          vim.g.VimuxOrientation = 'v'
        end,
        desc = '[T]est [V]ertical',
      },
      {
        '<leader>th',
        function()
          vim.g.VimuxOrientation = 'h'
        end,
        desc = '[T]est [H]orizontal',
      },
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
        -- log_level = vim.log.levels.INFO,
        output = {
          open_on_run = true,
        },
        adapters = {
          require 'neotest-phpunit' {
            -- dap = require('dap').configurations.php[1],
            filter_dirs = { '.git', 'node_modules', 'vendor' },
          },
          require 'neotest-python',
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
          vim.api.nvim_command 'wa'
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug Nearest',
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
