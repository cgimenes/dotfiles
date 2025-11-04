local dap = require 'dap'

local M = {}

M.setup = function()
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
end

return M
