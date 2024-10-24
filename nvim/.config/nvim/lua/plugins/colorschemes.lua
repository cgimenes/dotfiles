return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    opts = {
      style = 'darker',
    },
    init = function()
      -- require('onedark').load()
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = {
      transparent = true,
      style = 'storm',
      -- style = 'night',
      -- style = 'moon',
    },
    init = function()
      -- require('tokyonight').load()
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      transparent = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function()
        return {
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
        }
      end,
    },
    init = function()
      require('kanagawa').load 'wave'
      -- require('kanagawa').load("dragon")
      -- require('kanagawa').load("lotus")
    end,
  },
  {
    'catppuccin/nvim',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme "catppuccin-macchiato"
      -- vim.cmd.colorscheme "catppuccin-mocha"
      -- vim.cmd.colorscheme "catppuccin-frappe"
      -- vim.cmd.colorscheme "catppuccin-latte"
    end,
  },
  {
    'sainnhe/everforest',
    priority = 1000,
    init = function()
      -- vim.g.everforest_enable_italic = true
      -- vim.cmd.colorscheme 'everforest'
    end,
  },
  {
    'lunarvim/synthwave84.nvim',
    priority = 1000,
    opts = {
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
    },
    init = function()
      -- vim.cmd.colorscheme 'synthwave84'
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'nightfox'
      -- vim.cmd.colorscheme 'dayfox'
      -- vim.cmd.colorscheme 'dawnfox'
      -- vim.cmd.colorscheme 'duskfox'
      -- vim.cmd.colorscheme 'nordfox'
      -- vim.cmd.colorscheme 'terafox'
      -- vim.cmd.colorscheme 'carbonfox'
    end,
  },
  {
    'AlexvZyl/nordic.nvim',
    priority = 1000,
    init = function()
      -- require('nordic').load()
    end,
  },
  {
    'luisiacc/gruvbox-baby',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'gruvbox-baby'
    end,
  },
  {
    'tiagovla/tokyodark.nvim',
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    init = function()
      -- vim.cmd.colorscheme 'tokyodark'
    end,
  },
  {
    'cpea2506/one_monokai.nvim',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'one_monokai'
    end,
  },
}
