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
    'git',
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
    if vim.bo.filetype == 'snacks_picker_list' then
      return
    end
    vim.opt_local.cursorlineopt = 'number'
  end,
})

-- Disable automatic comment insertion on new lines
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('no-comment', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { 'o' }
  end,
})

-- Attach keymaps for quickfix list
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  desc = 'Attach keymaps for quickfix list',
  callback = function()
    vim.keymap.set('n', 'dd', function()
      local qf_list = vim.fn.getqflist()
      local current_line_number = vim.fn.line '.'
      if qf_list[current_line_number] then
        table.remove(qf_list, current_line_number)
        vim.fn.setqflist(qf_list, 'r')
        local new_line_number = math.min(current_line_number, #qf_list)
        vim.fn.cursor(new_line_number, 1)
      end
    end, { buffer = true, noremap = true, silent = true, desc = 'Remove quickfix item under cursor' })
  end,
})
