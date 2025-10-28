-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Use q to close certain windows
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('CloseWithQ', { clear = true }),
  command = [[nnoremap <buffer> q <cmd>q<cr>]],
  pattern = {
    'fugitive',
    'fugitiveblame',
    'gitsigns-blame',
    'grug-far',
    'help',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'qf',
    'spectre_panel',
    'dap-float',
  },
})

-- Close quickfix menu after selecting choice
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('quickfix-close-with-g<CR>', { clear = true }),
  command = [[nnoremap <buffer> g<CR> <CR>:cclose<CR>]],
  pattern = { 'qf' },
})

-- Terminal keymap
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-terminal', { clear = true }),
  callback = function(event)
    vim.keymap.set('n', 'gf', '<c-w>sgF<c-w>H<c-w>l<c-w>q', { buffer = event.buf })
  end,
})

-- Disable automatic comment insertion on new lines
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('no-comment', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { 'o' }
  end,
})

-- Keep at least `scrolloff` lines below the cursor when at the end of the file
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('ScrollOffEOF', { clear = true }),
  callback = function()
    local win_h = vim.api.nvim_win_get_height(0)
    local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
    local dist = vim.fn.line '$' - vim.fn.line '.'
    local rem = vim.fn.line 'w$' - vim.fn.line 'w0' + 1
    if dist < off and win_h - rem + dist < off then
      local view = vim.fn.winsaveview()
      view.topline = view.topline + off - (win_h - rem + dist)
      vim.fn.winrestview(view)
    end
  end,
})

-- Keep cursor centered when in diff mode (help with Octo.nvim sending the cursor some lines back after comments)
vim.api.nvim_create_autocmd('OptionSet', {
  group = vim.api.nvim_create_augroup('DiffScrollOff', { clear = true }),
  callback = function()
    if vim.opt.diff:get() then
      vim.opt_local.scrolloff = 100
    else
      vim.opt_local.scrolloff = 4
    end
  end,
  pattern = 'diff',
})
