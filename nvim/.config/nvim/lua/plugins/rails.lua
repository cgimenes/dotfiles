-- Extract partials/concerns -> :Extract <file>
-- Go to file -> gf
vim.pack.add { 'https://github.com/tpope/vim-rails' }
Map { '<leader>crr', '<cmd>R<cr>', desc = 'Rails Related File' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'eruby.yaml',
  command = 'set filetype=yaml',
})
