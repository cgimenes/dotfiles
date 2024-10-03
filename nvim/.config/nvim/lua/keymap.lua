-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('i', 'jk', '<Esc>')

-- Close everything
vim.keymap.set('n', '<C-q>', '<cmd>ccl<cr><cmd>Trouble close<cr><cmd>diffoff<cr><cmd>DiffviewClose<cr>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = '[N]ew Buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>windo diffthis<cr>', { desc = '[D]iff' })
vim.keymap.set('n', '<leader>bs', '<cmd>silent w!<cr>', { desc = '[S]ave file' })
vim.keymap.set('n', '<leader>w', '<C-w>')

vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

vim.keymap.set('n', '[<Space>', 'O<Esc>j')
vim.keymap.set('n', ']<Space>', 'o<Esc>k')

vim.keymap.set('n', '[q', '<cmd>cprev<cr>')
vim.keymap.set('n', ']q', '<cmd>cnext<cr>')

vim.keymap.set('v', '$', 'g_')
vim.keymap.set('v', 'J', '<cmd>m +1<cr>')
vim.keymap.set('v', 'K', '<cmd>m -2<cr>')

-- Better pasting experience
vim.keymap.set('v', '<leader>p', '"_dP', { desc = 'Paste without yanking' })
vim.keymap.set('n', '<leader>pe', '$p', { desc = 'Paste at the end of current line' })
vim.keymap.set('n', '<leader>pE', '$pa', { desc = 'Paste at the end of current line and enter insert mode' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Snippets
vim.keymap.set('n', '<leader>os', function()
  require('snippets').load_snippets()
end, { desc = 'Reload snippets' })

vim.keymap.set('n', '<leader>yr', '<cmd>let @+ = expand("%:.")<cr>', { desc = 'Yank relative filename' })
vim.keymap.set('n', '<leader>yf', '<cmd>let @+ = expand("%:p")<cr>', { desc = 'Yank full filename' })
vim.keymap.set('n', '<leader>yn', '<cmd>let @+ = expand("%:t")<cr>', { desc = 'Yank filename' })

-- Mouse support
vim.keymap.set('n', '<C-LeftMouse>', '<LeftMouse>gd')
vim.keymap.set('n', '<X1Mouse>', '<C-o>')
vim.keymap.set('n', '<X2Mouse>', '<C-i>')

-- Find/replace
vim.keymap.set('n', '<leader>rs', function()
  vim.ui.input({ prompt = 'Pattern: ' }, function(pattern)
    if pattern then
      vim.cmd('silent grep! ' .. pattern)
      vim.cmd 'copen'
    end
  end)
end, { desc = '[S]earch using :grep' })

vim.keymap.set('n', '<leader>rr', function()
  vim.ui.input({ prompt = 'Pattern: ' }, function(pattern)
    if pattern then
      vim.cmd('cdo s/' .. pattern .. '/gc | update')
    end
  end)
end, { desc = '[R]eplace using :cdo' })

vim.keymap.set('n', '<leader>cl', '<cmd>.lua<CR>', { desc = 'Execute the current line' })
vim.keymap.set('n', '<leader>cf', '<cmd>source %<CR>', { desc = 'Execute the current file' })

vim.keymap.set('n', '<leader>or', '<cmd>set relativenumber!<cr>', { desc = 'Toggle relative numbers' })
