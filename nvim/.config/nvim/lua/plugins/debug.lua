return {
  {
    'miroshQa/debugmaster.nvim',
    dependencies = {
      {
        'mfussenegger/nvim-dap',
        lazy = true,
        dependencies = {
          'nvim-neotest/nvim-nio',

          'theHamsta/nvim-dap-virtual-text',

          'mason-org/mason.nvim',
          'jay-babu/mason-nvim-dap.nvim',

          'leoluz/nvim-dap-go',
          'suketa/nvim-dap-ruby',
          { 'mfussenegger/nvim-dap-python', lazy = true },

          'stevearc/overseer.nvim',
        },
        config = function()
          local dap = require 'dap'

          require('mason-nvim-dap').setup {
            automatic_installation = true,
            handlers = {},
            ensure_installed = {
              'delve',
              'codelldb',
              'js-debug-adapter',
              'php-debug-adapter',
            },
          }

          require('nvim-dap-virtual-text').setup {}

          require('overseer').enable_dap()

          dap.adapters.node = {
            type = 'server',
            host = 'localhost',
            port = '${port}',
            executable = {
              command = vim.fn.stdpath 'data' .. '/mason/bin/js-debug-adapter',
              args = { '${port}' },
            },
          }

          dap.configurations.typescript = {
            {
              name = 'Launch Nest.js',
              type = 'node',
              request = 'launch',
              program = '${workspaceFolder}/src/main.ts',
              cwd = '${workspaceFolder}',
              protocol = 'inspector',
              runtimeArgs = { '--nolazy', '-r', 'ts-node/register', '-r', 'tsconfig-paths/register' },
              sourceMaps = true,
              envFile = '${workspaceFolder}/.env',
              console = 'integratedTerminal',
            },
            {
              name = 'Attach to node process',
              type = 'node',
              request = 'attach',
              -- rootPath = '${workspaceFolder}',
              processId = require('dap.utils').pick_process,
              cwd = vim.fn.getcwd(),
              sourceMaps = true,
            },
          }

          dap.configurations.php = {
            {
              type = 'php',
              request = 'launch',
              name = 'Listen for Xdebug',
              log = true,
              port = 9003,
              pathMappings = {
                ['/application'] = '${workspaceFolder}',
              },
            },
          }

          require('dap-go').setup {
            delve = {
              -- On Windows delve must be run attached or it crashes.
              -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
              detached = vim.fn.has 'win32' == 0,
            },
          }
          require('dap-ruby').setup()
          require('dap-python').setup 'python'

          vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
          vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
          vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

          vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
          vim.fn.sign_define('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
          vim.fn.sign_define('DapBreakpointRejected', { text = '●', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
          vim.fn.sign_define('DapLogPoint', {
            text = '●',
            texthl = 'DapLogPoint',
            linehl = 'DapLogPoint',
            numhl = 'DapLogPoint',
          })
          vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
        end,
      },
    },
    keys = {
      {
        '<leader>d',
        function()
          require('debugmaster').mode.toggle()
        end,
        mode = { 'n', 'v' },
        desc = 'Debug Mode',
      },
    },
    config = function()
      local dm = require 'debugmaster'
      dm.plugins.cursor_hl.enabled = false
    end,
  },
}
