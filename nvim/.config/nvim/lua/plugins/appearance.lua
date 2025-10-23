-- Cool icons
vim.pack.add { 'https://github.com/nvim-mini/mini.icons' }
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

-- Better quickfix window
vim.pack.add { 'https://github.com/yorickpeterse/nvim-pqf' }
require('pqf').setup {
  show_multiple_lines = true,
  max_filename_length = 40,
}

-- Better inline diagnostics
vim.pack.add { 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' }
require('tiny-inline-diagnostic').setup {
  preset = 'classic',
  options = {
    show_all_diags_on_cursorline = true,
  },
}

-- Improve notifications, command palette and more
vim.pack.add {
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/folke/noice.nvim',
}
require('noice').setup {
  messages = {
    enabled = true,
    view_search = false,
  },
  popupmenu = {
    enabled = false,
  },
  notify = {
    enabled = false,
  },
  presets = {
    command_palette = true,
  },
}

-- Highlight for Window separator
vim.pack.add { 'https://github.com/nvim-zh/colorful-winsep.nvim' }
require('colorful-winsep').setup {
  hi = {
    fg = '#e6c384',
  },
  symbols = { '─', '│', '╭', '╮', '╰', '╯' },
}

-- Auto arrange windows
vim.pack.add { 'https://github.com/folke/edgy.nvim' }
require('edgy').setup {
  animate = { enabled = false },
  -- exit_when_last = true,
  left = {
    {
      title = 'Find and Replace',
      ft = 'grug-far',
      size = { width = 0.20 },
    },
    {
      title = 'DBUI',
      ft = 'dbui',
      size = { width = 0.20 },
    },
  },
}
