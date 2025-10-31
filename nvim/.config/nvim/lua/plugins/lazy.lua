vim.pack.add { 'https://github.com/lumen-oss/lz.n' }
LazyMap = function(plugin)
  local keymap = require('lz.n').keymap(plugin)
  return function(opts)
    local mode = opts.mode or 'n'
    local key = opts[1]
    local cmd = opts[2]
    local desc = opts.desc
    keymap.set(mode, key, cmd, { desc = desc })
  end
end
