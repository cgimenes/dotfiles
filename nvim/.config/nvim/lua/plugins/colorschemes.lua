local transparent = false
vim.o.background = 'dark'

vim.pack.add { 'gh:rebelot/kanagawa.nvim' }
require('kanagawa').setup {
  transparent = transparent,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = 'none',
        },
      },
    },
  },
}

vim.cmd.colorscheme 'kanagawa-wave'
