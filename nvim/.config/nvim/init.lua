if vim.env.PROF then
  local snacks = vim.fn.stdpath 'data' .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  require('snacks.profiler').startup {
    startup = {
      event = 'VimEnter',
    },
  }
end

require 'set'
require 'keymap'
require 'autocmd'
require 'lazy-init'
require 'snippets'
require 'usercmd'
require 'mouse'
