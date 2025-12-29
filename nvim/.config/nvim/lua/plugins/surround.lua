-- Surround text objects
-- Replace: sr"' or sr'<q> or even srt"
-- Delete: sd"
-- Add: saiw]
-- Visual mode: sa"
vim.pack.add { 'https://github.com/nvim-mini/mini.surround' }
require('mini.surround').setup()

-- vim.pack.add { 'https://github.com/tpope/vim-surround' }
-- vim.pack.add { 'https://github.com/machakann/vim-sandwich' }

-- Make surround repeatable
-- vim.pack.add { 'https://github.com/tpope/vim-repeat' }
