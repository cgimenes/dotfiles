-- vim.pack.add { 'https://github.com/altermo/ultimate-autopair.nvim' }
-- require('ultimate-autopair').setup {
--   bs = { delete_from_end = false },
-- }

-- Adds "end" in Ruby, etc.
vim.pack.add { 'https://github.com/tpope/vim-endwise' }

-- Closes brackets, parentheses, quotes, etc. On <CR> and on <C-O>
vim.pack.add { 'https://github.com/rstacruz/vim-closer' }
vim.g.pairify_map = '<C-O>'
vim.pack.add { 'https://github.com/dhruvasagar/vim-pairify' }
