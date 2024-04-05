return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    init = function()
      require('onedark').setup {
        style = 'darker',
      }
      -- require('onedark').load()
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      require('tokyonight').setup {
        style = 'storm',
        -- style = 'night',
        -- style = 'moon',
      }
      -- require('tokyonight').load()
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
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
    'nordtheme/vim',
    priority = 1000,
    init = function()
      -- vim.opt.termguicolors = true
      -- vim.cmd.colorscheme 'nord'
    end,
  },
}
