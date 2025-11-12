-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Use q to close certain windows
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Use q to close certain windows',
  group = vim.api.nvim_create_augroup('CloseWithQ', { clear = true }),
  command = [[nnoremap <buffer> q <cmd>q<cr>]],
  pattern = {
    'dap-float',
    'fugitive',
    'fugitiveblame',
    'gitsigns-blame',
    'grug-far',
    'help',
    'nvim-undotree',
    'qf',
    'toggleterm',
  },
})

-- Keep at least `scrolloff` lines below the cursor when at the end of the file
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
  desc = 'Keep at least `scrolloff` lines below the cursor when at the end of the file',
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

-- Highlight cursor line only in active window
local group = vim.api.nvim_create_augroup('cursor-line', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = group,
  desc = 'Highlight cursor line only in active window',
  callback = function()
    vim.opt_local.cursorlineopt = 'both'
  end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = group,
  desc = 'Remove cursor line highlight in inactive window',
  callback = function()
    vim.opt_local.cursorlineopt = 'number'
  end,
})
