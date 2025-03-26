return {
  {
    'vim-test/vim-test',
    cmd = 'TestSuite',
    dependencies = {
      'preservim/vimux',
    },
    config = function()
      vim.cmd "let test#strategy = 'vimux'"
      vim.cmd 'let test#echo_command = 0'
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
      'nvim-neotest/neotest-jest',
    },
    config = function()
      require('neotest').setup {
        output = {
          open_on_run = true,
        },
        status = { virtual_text = true },
        quickfix = {
          open = function()
            vim.cmd 'copen'
          end,
        },
        adapters = {
          require 'neotest-phpunit' {
            filter_dirs = { '.git', 'node_modules', 'vendor' },
          },
          require 'neotest-python' {
            dap = { justMyCode = false },
          },
          require 'neotest-jest' {
            jestCommand = 'npm test --',
            jestConfigFile = 'custom.jest.config.ts',
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
        summary = {
          animated = false,
        },
        icons = {
          expanded = '',
          non_collapsible = '',
          collapsed = '',

          passed = '',
          running = '',
          failed = '',
          unknown = '',
        },
      }
      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)
    end,
    keys = {
      {
        '<leader>tdn',
        function()
          vim.api.nvim_command 'silent! wa'
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug Nearest',
      },
      {
        '<leader>tdl',
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
      {
        '<leader>tu',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Show UI',
      },
    },
  },
}
