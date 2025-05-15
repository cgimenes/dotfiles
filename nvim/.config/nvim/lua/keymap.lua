-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('t', '<C-/>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Close everything (quickfix, location list, diffview and Diffview.nvim)
vim.keymap.set('n', '<C-q>', '<cmd>ccl<cr><cmd>lcl<cr><cmd>diffoff<cr><cmd>DiffviewClose<cr>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New Buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>windo diffthis<cr>', { desc = 'Diff' })
vim.keymap.set('n', '<leader>bs', '<cmd>silent wa!<cr>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>w', '<C-w>')

vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

vim.keymap.set('v', '$', 'g_')

-- Better pasting experience
vim.keymap.set('v', '<leader>pp', '"_dP', { desc = 'Paste without yanking' })
vim.keymap.set('n', '<leader>pe', '$p', { desc = 'Paste at the end of current line' })
vim.keymap.set('n', '<leader>pE', '$pa', { desc = 'Paste at the end of current line and enter insert mode' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Yank filename
vim.keymap.set('n', '<leader>yr', '<cmd>let @+ = expand("%:.")<cr>', { desc = 'Yank relative filename' })
vim.keymap.set('n', '<leader>yf', '<cmd>let @+ = expand("%:p")<cr>', { desc = 'Yank full filename' })
vim.keymap.set('n', '<leader>yn', '<cmd>let @+ = expand("%:t")<cr>', { desc = 'Yank filename' })

-- Mouse support
vim.keymap.set('n', '<C-LeftMouse>', '<LeftMouse>gd')
vim.keymap.set('n', '<X1Mouse>', '<C-o>')
vim.keymap.set('n', '<X2Mouse>', '<C-i>')

-- Find/replace
vim.keymap.set('n', '<leader>fs', function()
  local cword = vim.fn.expand '<cword>'
  vim.ui.input({ prompt = 'Pattern: ', default = cword }, function(pattern)
    if pattern then
      vim.cmd('silent grep! ' .. pattern)
      vim.cmd 'copen'
    end
  end)
end, { desc = 'Search using :grep' })

vim.keymap.set('n', '<leader>fr', function()
  vim.ui.input({ prompt = 'Pattern: ', default = '\\V' }, function(pattern)
    if pattern then
      vim.cmd('cdo s/' .. pattern .. '/gc | update')
    end
  end)
end, { desc = 'Replace using :cdo' })

-- Execute code
vim.keymap.set('n', '<leader>cl', '<cmd>.lua<CR>', { desc = 'Execute the current line' })
vim.keymap.set('v', '<leader>cv', ':.lua<CR>', { desc = 'Execute the current selection' })
vim.keymap.set('n', '<leader>cf', '<cmd>source %<CR>', { desc = 'Execute the current file' })

-- Toggle relative numbers
vim.keymap.set('n', '<leader>or', '<cmd>set relativenumber!<cr>', { desc = 'Toggle relative numbers' })
vim.keymap.set('n', '<leader>os', '<cmd>set spell!<cr>', { desc = 'Toggle spelling' })
