-- Fugitive
vim.pack.add {
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-fugitive',
}
Map { '<leader>gB', ':GBrowse<cr>', desc = 'Git Browse', mode = { 'n', 'x' } }
Map { '<leader>gb', '<cmd>G blame<cr>', desc = 'Git Blame' }
Map { '<leader>gc', '<cmd>G mergetool<cr>', desc = 'List Git Conflicts' }

-- CodeDiff
vim.pack.add {
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/esmuellert/codediff.nvim',
}
Map { '<leader>gh', ':CodeDiff history %<cr>', desc = 'File History' }
Map { '<leader>gd', '<cmd>CodeDiff<cr>', desc = 'Git Diff' }
Map { '<leader>gD', '<cmd>CodeDiff main...HEAD<cr>', desc = 'Git Diff main...HEAD (PR-like)' }

-- Git signs (textobjects and hunk actions: gh to apply and gH to reset)
vim.pack.add { 'https://github.com/nvim-mini/mini.diff' }
require('mini.diff').setup {
  view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '▁' } },
  mappings = {
    goto_first = '[C',
    goto_prev = '[c',
    goto_next = ']c',
    goto_last = ']C',
  },
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
Map { '<leader>Gl', '<cmd>Octo pr list<cr>', desc = 'List' }
Map { '<leader>Gr', '<cmd>Octo review<cr>', desc = 'Review' }
Map { '<leader>Gt', '<cmd>Octo review thread<cr>', desc = 'Show Thread' }

-- Resolve git conflicts
require('plugins.git-resolve').setup {}
