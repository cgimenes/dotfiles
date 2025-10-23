if vim.env.PROF then
  local snacks = vim.fn.stdpath 'data' .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  require('snacks.profiler').startup {
    startup = {
      event = 'VimEnter',
    },
  }
end

require 'options'
require 'keymap'
require 'autocmd'
require 'plugins'
require 'usercmd'
require 'mouse'
require 'macros'
