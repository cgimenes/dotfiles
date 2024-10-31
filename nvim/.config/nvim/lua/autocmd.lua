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
    'neotest-summary',
    'help',
    'fugitiveblame',
    'grug-far',
  },
})

-- Enable folding with treesitter
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if require('nvim-treesitter.parsers').has_parser() then
      vim.opt.foldmethod = 'expr'
      vim.opt.foldlevel = 10
      vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    else
      vim.opt.foldmethod = 'manual'
    end
  end,
})
