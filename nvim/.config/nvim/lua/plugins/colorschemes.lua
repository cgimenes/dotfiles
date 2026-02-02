local transparent = false

vim.pack.add { 'https://github.com/olimorris/onedarkpro.nvim' }
require('onedarkpro').setup {
  options = {
    transparency = transparent,
    lualine_transparency = transparent,
  },
}

vim.pack.add { 'https://github.com/folke/tokyonight.nvim' }
require('tokyonight').setup { transparent = transparent }

vim.pack.add { 'https://github.com/rebelot/kanagawa.nvim' }
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

vim.pack.add {
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
}

vim.pack.add { 'https://github.com/sainnhe/everforest' }
vim.g.everforest_enable_italic = true

vim.pack.add { 'https://github.com/lunarvim/synthwave84.nvim' }
require('synthwave84').setup {
  glow = {
    error_msg = false,
    type2 = false,
    func = false,
    keyword = false,
    operator = false,
    buffer_current_target = false,
    buffer_visible_target = false,
    buffer_inactive_target = false,
  },
}

vim.pack.add { 'https://github.com/EdenEast/nightfox.nvim' }

vim.pack.add { 'https://github.com/AlexvZyl/nordic.nvim' }

vim.pack.add { 'https://github.com/luisiacc/gruvbox-baby' }
vim.g.gruvbox_material_enable_italic = true
vim.g.gruvbox_material_enable_bold = true
vim.g.gruvbox_material_transparent_background = transparent
vim.g.gruvbox_material_foreground = 'original'
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_float_style = 'dim'
vim.g.gruvbox_material_better_performance = 1

vim.pack.add { 'https://github.com/tiagovla/tokyodark.nvim' }
require('tokyodark').setup { transparent_background = transparent }

vim.pack.add { 'https://github.com/cpea2506/one_monokai.nvim' }

vim.pack.add { 'https://github.com/scottmckendry/cyberdream.nvim' }
require('cyberdream').setup { transparent = transparent }

vim.pack.add { 'https://github.com/lunarvim/darkplus.nvim' }

vim.pack.add { 'https://github.com/bluz71/vim-moonfly-colors' }

vim.pack.add { 'https://github.com/webhooked/kanso.nvim' }
require('kanso').setup { transparent = transparent }

vim.pack.add { 'https://github.com/Yazeed1s/oh-lucy.nvim' }
vim.g.oh_lucy_transparent_background = transparent

vim.pack.add { 'https://github.com/vague2k/vague.nvim' }
require('vague').setup { transparent = transparent }

vim.pack.add { 'https://github.com/craftzdog/solarized-osaka.nvim' }
require('solarized-osaka').setup { transparent = transparent }

vim.pack.add { 'https://github.com/sainnhe/gruvbox-material' }

vim.pack.add { 'https://github.com/xeind/nightingale.nvim' }
require('nightingale').setup { transparent = transparent }

vim.pack.add { 'https://github.com/NTBBloodbath/sweetie.nvim' }
vim.o.background = 'dark'

vim.pack.add { 'https://github.com/thesimonho/kanagawa-paper.nvim' }
require('kanagawa-paper').setup { transparent = transparent }

vim.pack.add { 'https://github.com/adibhanna/yukinord.nvim' }

vim.pack.add { 'https://gitlab.com/motaz-shokry/gruvbox.nvim' }

-- vim.cmd.colorscheme 'onedark'
-- vim.cmd.colorscheme 'tokyonight-night'
-- vim.cmd.colorscheme 'tokyonight-storm'
-- vim.cmd.colorscheme 'tokyonight-day'
-- vim.cmd.colorscheme 'tokyonight-moon'
vim.cmd.colorscheme 'kanagawa-wave'
-- vim.cmd.colorscheme 'kanagawa-dragon'
-- vim.cmd.colorscheme 'kanagawa-lotus'
-- vim.cmd.colorscheme 'kanagawa-paper-ink'
-- vim.cmd.colorscheme 'kanagawa-paper-canvas'
-- vim.cmd.colorscheme 'catppuccin-macchiato'
-- vim.cmd.colorscheme 'catppuccin-mocha'
-- vim.cmd.colorscheme 'catppuccin-frappe'
-- vim.cmd.colorscheme 'catppuccin-latte'
-- vim.cmd.colorscheme 'everforest'
-- vim.cmd.colorscheme 'synthwave84'
-- vim.cmd.colorscheme 'nightfox'
-- vim.cmd.colorscheme 'dayfox'
-- vim.cmd.colorscheme 'dawnfox'
-- vim.cmd.colorscheme 'duskfox'
-- vim.cmd.colorscheme 'nordfox'
-- vim.cmd.colorscheme 'terafox'
-- vim.cmd.colorscheme 'carbonfox'
-- vim.cmd.colorscheme 'nordic'
-- vim.cmd.colorscheme 'gruvbox-baby'
-- vim.cmd.colorscheme 'gruvbox-hard'
-- vim.cmd.colorscheme 'tokyodark'
-- vim.cmd.colorscheme 'one_monokai'
-- vim.cmd.colorscheme 'cyberdream'
-- vim.cmd.colorscheme 'darkplus'
-- vim.cmd.colorscheme 'moonfly'
-- vim.cmd.colorscheme 'kanso-zen'
-- vim.cmd.colorscheme 'kanso-kage'
-- vim.cmd.colorscheme 'kanso-pearl'
-- vim.cmd.colorscheme 'oh-lucy'
-- vim.cmd.colorscheme 'oh-lucy-evening'
-- vim.cmd.colorscheme 'vague'
-- vim.cmd.colorscheme 'solarized-osaka'
-- vim.cmd.colorscheme 'gruvbox-material'
-- vim.cmd.colorscheme 'nightingale'
-- vim.cmd.colorscheme 'sweetie'
-- vim.cmd.colorscheme 'yukinord'
