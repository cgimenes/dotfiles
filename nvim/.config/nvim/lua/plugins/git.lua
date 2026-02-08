-- Fugitive
vim.pack.add {
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-fugitive',
}
Map { '<leader>gB', ':GBrowse<cr>', desc = 'Git Browse', mode = { 'n', 'x' } }
Map { '<leader>gb', '<cmd>G blame<cr>', desc = 'Git Blame' }
Map { '<leader>gc', '<cmd>G mergetool<cr>', desc = 'List Git Conflicts' }
Map { '<leader>gd', '<cmd>vertical G diff HEAD %<cr>', desc = 'Git Diff Current File' }

-- CodeDiff
vim.pack.add {
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/esmuellert/codediff.nvim',
}
Map { '<leader>gh', ':CodeDiff history %<cr>', desc = 'File History' }
Map { '<leader>gD', '<cmd>CodeDiff<cr>', desc = 'Git Diffview' }

-- Git signs (textobjects and hunk actions: gh to apply and gH to reset)
vim.pack.add { 'https://github.com/nvim-mini/mini.diff' }
require('mini.diff').setup {
  view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '▁' } },
}
Map {
  '<leader>ho',
  MiniDiff.toggle_overlay,
  desc = 'Toggle Git Changes Overlay',
}

-- Octo.nvim (GitHub PRs and Issues)
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/pwntester/octo.nvim',
}
require('octo').setup {
  enable_builtin = true,
  picker = 'snacks',
  use_local_fs = true,
  file_panel = { size = 5 },
  reviews = { auto_show_threads = false },
}
Map { '<leader>gpl', '<cmd>Octo pr list<cr>', desc = 'List' }
Map { '<leader>gpr', '<cmd>Octo review<cr>', desc = 'Review' }
Map { '<leader>gpt', '<cmd>Octo review thread<cr>', desc = 'Show Thread' }

-- Resolve git conflicts
require('plugins.git-resolve').setup {}
