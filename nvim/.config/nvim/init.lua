require 'set'
require 'keymap'
require 'autocmd'
require 'lazy-init'
require 'snippets'
require 'usercmd'

P = function(v)
  print(vim.inspect(v))
  return v
end
