-- Surround text objects
-- Replace: sr"' or sr'<q> or even srt"
-- Delete: sd"
-- Add: saiw]
-- Visual mode: sa"
vim.pack.add { 'gh:nvim-mini/mini.surround' }
require('mini.surround').setup { search_method = 'cover_or_next' }

-- vim.pack.add { 'gh:tpope/vim-surround' }
-- vim.pack.add { 'gh:machakann/vim-sandwich' }

-- Make surround repeatable
-- vim.pack.add { 'gh:tpope/vim-repeat' }
