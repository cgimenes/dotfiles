return {
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker',
      }
      -- require('onedark').load()
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'storm',
        -- style = 'night',
        -- style = 'moon',
      }
      -- require('tokyonight').load()
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').load("wave")
      -- require('kanagawa').load("dragon")
      -- require('kanagawa').load("lotus")
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme "catppuccin-macchiato"
      -- vim.cmd.colorscheme "catppuccin-mocha"
      -- vim.cmd.colorscheme "catppuccin-frappe"
      -- vim.cmd.colorscheme "catppuccin-latte"
    end,
  }
}
