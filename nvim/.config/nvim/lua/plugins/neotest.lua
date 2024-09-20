return {
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
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
        '<leader>tA',
        function()
          vim.api.nvim_command 'write'
          require('neotest').run.run(vim.loop.cwd())
        end,
        desc = 'Run All Test Files',
      },
      {
        '<leader>tf',
        function()
          vim.api.nvim_command 'write'
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run File',
      },
      {
        '<leader>tF',
        function()
          vim.api.nvim_command 'write'
          require('neotest').run.run(vim.fn.expand '%', { strategy = 'dap' })
        end,
        desc = 'Debug File',
      },
      {
        '<leader>tr',
        function()
          vim.api.nvim_command 'write'
          require('neotest').run.run()
        end,
        desc = 'Run Nearest',
      },
      {
        '<leader>tR',
        function()
          vim.api.nvim_command 'write'
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug Nearest',
      },
      {
        '<leader>tl',
        function()
          vim.api.nvim_command 'write'
          require('neotest').run.run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>tl',
        function()
          vim.api.nvim_command 'write'
          require('neotest').run.run_last { strategy = 'dap' }
        end,
        desc = 'Debug Last',
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
