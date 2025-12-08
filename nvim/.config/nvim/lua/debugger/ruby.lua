local dap = require 'dap'

local M = {}

M.setup = function()
  dap.adapters.ruby = function(callback, config)
    local port = math.random(49152, 65535)
    callback {
      type = 'server',
      host = '127.0.0.1',
      port = port,
      executable = {
        command = 'bundle',
        args = { 'exec', 'rdbg', '-n', '--open', '--port', port, '-c', '--', 'bundle', 'exec', config.command, config.script },
      },
    }
  end

  dap.configurations.ruby = {
    {
      name = 'debug current file',
      command = 'ruby',
      type = 'ruby',
      request = 'attach',
      localfs = true,
      script = '${file}',
    },
    {
      name = 'run current spec file',
      command = 'rspec',
      type = 'ruby',
      request = 'attach',
      localfs = true,
      script = '${file}',
    },
    {
      name = 'run bin/dev',
      command = 'bin/dev',
      type = 'ruby',
      request = 'attach',
      localfs = true,
    },
  }
end

return M
