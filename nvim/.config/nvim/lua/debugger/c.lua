local dap = require 'dap'

local M = {}

M.setup = function()
  dap.adapters['codelldb'] = {
    type = 'server',
    port = '${port}',
    executable = {
      command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
      args = { '--port', '${port}' },
    },
  }
end

return M
