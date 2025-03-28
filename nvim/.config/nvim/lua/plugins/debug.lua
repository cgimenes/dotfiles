return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'nvim-neotest/nvim-nio',

      { 'igorlfs/nvim-dap-view', config = true },

      'theHamsta/nvim-dap-virtual-text',

      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      'leoluz/nvim-dap-go',
      'suketa/nvim-dap-ruby',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require 'dap'
      local dv = require 'dap-view'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
          'codelldb',
        },
      }

      require('nvim-dap-virtual-text').setup {}

      dap.listeners.before.attach['dap-view-config'] = function()
        dv.open()
      end
      dap.listeners.before.launch['dap-view-config'] = function()
        dv.open()
      end
      dap.listeners.before.event_terminated['dap-view-config'] = function()
        dv.close()
      end
      dap.listeners.before.event_exited['dap-view-config'] = function()
        dv.close()
      end

      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { vim.fn.stdpath 'cache' .. '/debuggers/vscode-php-debug/out/phpDebug.js' },
      }

      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode',
        name = 'lldb',
      }

      dap.configurations.c = {
        {
          name = 'LLDB',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          env = { 'LD_LIBRARY_PATH=./build/' },
        },
      }

      -- git clone https://github.com/xdebug/vscode-php-debug.git ~/.cache/nvim/debuggers/vscode-php-debug
      -- cd ~/.cache/nvim/debuggers/vscode-php-debug
      -- npm install && npm run build

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
    keys = {
      { '<leader>dt', '<cmd>DapToggleBreakpoint<cr>', desc = 'Toggle Breakpoint' },
      { '<leader>dc', '<cmd>DapContinue<cr>', desc = 'Continue' },
      { '<leader>di', '<cmd>DapStepInto<cr>', desc = 'Step Into' },
      { '<leader>dn', '<cmd>DapStepOver<cr>', desc = 'Step Over/Next Line' },
      { '<leader>do', '<cmd>DapStepOut<cr>', desc = 'Step Out' },
      { '<leader>dr', '<cmd>DapToggleRepl<cr>', desc = 'Toggle Repl' },
      { '<leader>dq', '<cmd>DapTerminate<cr>', desc = 'Terminate' },
      {
        '<leader>db',
        function()
          require('dap').step_back()
        end,
        desc = 'Step Back',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run To Cursor',
      },
      {
        '<leader>dp',
        function()
          require('dap').pause()
        end,
        desc = 'Pause',
      },
      {
        '<leader>dU',
        function()
          require('dap-view').toggle()
        end,
        desc = 'Toggle UI',
      },
      {
        '<leader>dT',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
    },
  },
}
