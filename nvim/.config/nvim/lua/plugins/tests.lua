local vim_test_file_types = {
  ['php'] = true,
}

local function use_vim_test()
  if vim_test_file_types[vim.bo.filetype] then
    return true
  end
  return false
end

return {
  {
    'nvim-neotest/neotest',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/neotest-vim-test',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-jest',
      {
        'vim-test/vim-test',
        dependencies = {
          'preservim/vimux',
        },
        config = function()
          vim.cmd "let test#strategy = 'vimux'"
          vim.cmd 'let test#echo_command = 0'
          vim.g.VimuxCloseOnExit = 1
        end,
      },
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
        consumers = {
          overseer = require 'neotest.consumers.overseer',
        },
        adapters = {
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
        '<leader>tn',
        function()
          vim.api.nvim_command 'silent! wa'
          if use_vim_test() then
            vim.api.nvim_command 'TestNearest'
          else
            require('neotest').run.run()
          end
        end,
        desc = 'Test Nearest',
      },
      {
        '<leader>tf',
        function()
          vim.api.nvim_command 'silent! wa'
          if use_vim_test() then
            vim.api.nvim_command 'TestFile'
          else
            require('neotest').run.run(vim.fn.expand '%')
          end
        end,
        desc = 'Test File',
      },
      {
        '<leader>ts',
        function()
          vim.api.nvim_command 'silent! wa'
          if use_vim_test() then
            vim.api.nvim_command 'TestSuite'
          else
            require('neotest').run.run { suite = true }
          end
        end,
        desc = 'Test Suite',
      },
      {
        '<leader>tl',
        function()
          vim.api.nvim_command 'silent! wa'
          if use_vim_test() then
            vim.api.nvim_command 'TestLast'
          else
            require('neotest').run.run_last()
          end
        end,
        desc = 'Test Last',
      },
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
        '<leader>tO',
        function()
          require('neotest').output_panel.open()
        end,
        desc = 'Show Output Panel',
      },
      {
        '<leader>tu',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Show UI',
      },
      {
        '<leader>tq',
        '<cmd>VimuxCloseRunner<cr>',
        desc = 'Test Quit',
      },
    },
  },
}
