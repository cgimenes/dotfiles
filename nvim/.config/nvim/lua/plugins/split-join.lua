-- Splitting/joining blocks of code
vim.pack.add { 'https://github.com/Wansmer/treesj' }
require('treesj').setup { use_default_keymaps = false }
Map { '<space>lm', '<cmd>TSJToggle<cr>', desc = 'Split or Join code block with autodetect' }
