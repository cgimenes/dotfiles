require 'set'
require 'keymap'
require 'autocmd'
require 'lazy-init'
require 'snippets'

P = function(v)
  print(vim.inspect(v))
  return v
end
