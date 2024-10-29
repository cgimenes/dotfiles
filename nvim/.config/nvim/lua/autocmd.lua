-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Use q to close certain windows
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('CloseWithQ', { clear = true }),
  callback = function(args)
    vim.keymap.set('n', 'q', '<cmd>q<cr>', { buffer = args.buf })
  end,
  pattern = {
    'spectre_panel',
    'neotest-output',
    'neotest-output-panel',
    'help',
    'fugitiveblame',
    'grug-far',
  },
})
