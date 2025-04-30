return {
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
    opts = {
      options = {
        transparency = true,
        lualine_transparency = true,
      },
    },
    init = function()
      -- vim.cmd.colorscheme 'onedark'
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
      overrides = function(colors)
        local theme = colors.theme
        local makeDiagnosticColor = function(color)
          local c = require 'kanagawa.lib.color'
          return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end
        return {
          BlinkCmpDoc = { bg = theme.ui.bg_p1 },
          DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          PmenuExtra = { bg = theme.ui.bg_p1 },
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
  {
    'scottmckendry/cyberdream.nvim',
    priority = 1000,
    opts = {
      transparent = true,
    },
    init = function()
      -- vim.cmd.colorscheme 'cyberdream'
    end,
  },
  {
    'lunarvim/darkplus.nvim',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'darkplus'
    end,
  },
  {
    'bluz71/vim-moonfly-colors',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'moonfly'
    end,
  },
}
