-- Splitting/joining blocks of code

-- vim.pack.add { 'https://github.com/Wansmer/treesj' }
-- require('treesj').setup { use_default_keymaps = false }
-- Map { '<space>lm', '<cmd>TSJToggle<cr>', desc = 'Split or Join code block with autodetect' }

vim.pack.add { 'https://github.com/nvim-mini/mini.splitjoin' }
require('mini.splitjoin').setup {
  mappings = { toggle = '<space>lm' },
}
