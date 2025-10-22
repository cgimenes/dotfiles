return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mason-org/mason.nvim',
      'stevearc/overseer.nvim',

      'leoluz/nvim-dap-go',
      'suketa/nvim-dap-ruby',
      'mfussenegger/nvim-dap-python',
    },
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dK", function() require("dap.ui.widgets").hover(nil, { border = "rounded" }) end, desc = "Eval" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dT", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>dd", function() require("dap").down() end, desc = "Down in stacktrace" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dn", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>du", function() require("dap").up() end, desc = "Up in stacktrace" },
    },
    config = function()
      local dap = require 'dap'

      require('nvim-dap-virtual-text').setup {}

      require('overseer').enable_dap()

      dap.adapters['codelldb'] = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }

      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }

      dap.configurations['typescript'] = {
        -- {
        --   name = 'Launch Nest.js',
        --   type = 'pwa-node',
        --   request = 'launch',
        --   program = '${workspaceFolder}/src/main.ts',
        --   cwd = '${workspaceFolder}',
        --   protocol = 'inspector',
        --   runtimeArgs = { '--nolazy', '-r', 'ts-node/register', '-r', 'tsconfig-paths/register' },
        --   sourceMaps = true,
        --   envFile = '${workspaceFolder}/.env',
        --   console = 'integratedTerminal',
        -- },
        {
          name = 'Attach to node process',
          type = 'pwa-node',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
      }

      dap.configurations['php'] = {
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
      require('dap-python').setup 'uv'

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
  {
    'igorlfs/nvim-dap-view',
    cmd = { 'DapViewToggle' },
    keys = {
      { '<leader>dU', '<cmd>DapViewToggle!<cr>', desc = 'Dap UI' },
    },
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      auto_toggle = true,
      windows = {
        terminal = {
          position = 'right',
        },
      },
    },
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    event = 'VeryLazy',
  },
  {
    'nvimtools/hydra.nvim',
    event = 'VeryLazy',
    config = function()
      local Hydra = require 'hydra'
      local dap = require 'dap'

      Hydra {
        hint = [[
 _n_: Step Over         _K_: Eval
 _i_: Step Into         ^ ^
 _o_: Step Out          _T_: Terminate
 _C_: To Cursor         _q_: Exit Mode
 _c_: Continue/Start
]],
        config = {
          color = 'pink',
          invoke_on_body = true,
          hint = {
            position = 'top-right',
            offset = 1,
          },
        },
        name = 'DAP mode',
        mode = { 'n', 'x' },
        body = '<leader>dm',
        -- stylua: ignore
        heads = {
          { 'n', dap.step_over, { silent = true } },
          { 'i', dap.step_into, { silent = true } },
          { 'o', dap.step_out, { silent = true } },
          { 'C', dap.run_to_cursor, { silent = true } },
          { 'c', dap.continue, { silent = true } },
          { 'T', dap.terminate, { exit = true, silent = true } },
          { 'K', function() require('dap.ui.widgets').hover(nil, { border = "rounded" }) end, { silent = true } },
          { 'q', nil, { exit = true, nowait = true } },
        },
      }
    end,
  },
}
