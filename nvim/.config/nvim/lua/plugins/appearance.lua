-- Cool icons
vim.pack.add { 'gh:nvim-mini/mini.icons' }
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

-- Better quickfix window
vim.pack.add { 'gh:yorickpeterse/nvim-pqf' }
require('pqf').setup {
  show_multiple_lines = true,
  max_filename_length = 40,
}

-- Better inline diagnostics
vim.pack.add { 'gh:rachartier/tiny-inline-diagnostic.nvim' }
require('tiny-inline-diagnostic').setup {
  preset = 'simple',
  options = {
    show_all_diags_on_cursorline = true,
  },
}
Map {
  '<leader>od',
  require('tiny-inline-diagnostic').toggle,
  desc = 'Toggle inline diagnostics',
}

-- Improve notifications, command palette and more
vim.pack.add {
  'gh:MunifTanjim/nui.nvim',
  'gh:folke/noice.nvim',
}
require('noice').setup {
  cmdline = { view = 'cmdline' },
  messages = { enabled = true, view_search = false },
  popupmenu = { enabled = false },
  notify = { enabled = false },
  presets = { command_palette = true },
  lsp = { progress = { enabled = false } },
}

-- Highlight for window separator
vim.pack.add { 'gh:nvim-zh/colorful-winsep.nvim' }
require('colorful-winsep').setup {
  highlight = '#e6c384',
  animate = { enabled = false },
}

-- Auto arrange windows
vim.pack.add { 'gh:folke/edgy.nvim' }
require('edgy').setup {
  animate = { enabled = false },
  left = {
    { title = 'Find and Replace', ft = 'grug-far', size = { width = 0.20 } },
    { title = 'DBUI', ft = 'dbui', size = { width = 0.20 } },
    { title = 'UndoTree', ft = 'nvim-undotree', size = { width = 0.30 } },
  },
  right = {
    { title = 'Outline', ft = 'Outline', size = { width = 0.30 } },
  },
}
