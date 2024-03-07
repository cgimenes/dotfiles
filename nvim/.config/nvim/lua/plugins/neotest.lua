return {
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'olimorris/neotest-phpunit',
    },
    config = function()
      require('neotest').setup {
        -- log_level = vim.log.levels.INFO,
        output = {
          open_on_run = true,
        },
        adapters = {
          require 'neotest-phpunit' {
            dap = require('dap').configurations.php[1],
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
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug Nearest',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run File',
      },
      {
        '<leader>tF',
        function()
          require('neotest').run.run(vim.loop.cwd())
        end,
        desc = 'Run All Test Files',
      },
      {
        '<leader>tr',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest',
      },
      {
        '<leader>tl',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Summary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = 'Show Output',
      },
      {
        '<leader>tO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle Output Panel',
      },
      {
        '<leader>tS',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop',
      },
      {
        '<leader>tc',
        function()
          require('neotest').output_panel.clear()
        end,
        desc = 'Clear Output Panel',
      },
    },
  },
}
