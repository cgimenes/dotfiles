local dap = require 'dap'

local M = {}

M.setup = function()
  -- dap.configurations['php'] = {
  --   {
  --     type = 'php',
  --     request = 'launch',
  --     name = 'Listen for Xdebug',
  --     log = true,
  --     port = 9003,
  --     pathMappings = {
  --       ['/application'] = '${workspaceFolder}',
  --     },
  --   },
  -- }
end

return M
