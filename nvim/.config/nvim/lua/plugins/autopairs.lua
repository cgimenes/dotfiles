-- vim.pack.add { 'gh:altermo/ultimate-autopair.nvim' }
-- require('ultimate-autopair').setup {
--   bs = { delete_from_end = false },
-- }

-- Adds "end" in Ruby, etc.
vim.pack.add { 'gh:tpope/vim-endwise' }

-- Closes brackets, parentheses, quotes, etc. On <CR> and on <C-O>
vim.pack.add { 'gh:rstacruz/vim-closer' }
vim.g.pairify_map = '<C-O>'
vim.pack.add { 'gh:dhruvasagar/vim-pairify' }
