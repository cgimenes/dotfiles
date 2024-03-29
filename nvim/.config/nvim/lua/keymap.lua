-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('i', 'jk', '<Esc>')

-- Close everything
vim.keymap.set('n', '<C-q>', '<cmd>ccl<cr><cmd>TroubleClose<cr><cmd>DiffviewClose<cr>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = '[N]ew Buffer' })
vim.keymap.set('n', '<leader>w', '<cmd>w!<cr>', { desc = '[W]rite to File' })

vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

vim.keymap.set('n', '[<Space>', 'O<Esc>j')
vim.keymap.set('n', ']<Space>', 'o<Esc>k')

vim.keymap.set('n', '[q', '<cmd>cprev<cr>')
vim.keymap.set('n', ']q', '<cmd>cnext<cr>')

vim.keymap.set('v', '$', 'g_')

-- Better pasting experience
vim.keymap.set('v', '<leader>p', '"_dP', { desc = 'Paste without yanking' })
vim.keymap.set('n', '<leader>pe', '$p', { desc = 'Paste at the end of current line' })
vim.keymap.set('n', '<leader>pE', '$pa', { desc = 'Paste at the end of current line and enter insert mode' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Oil
vim.keymap.set('n', '<leader>E', '<cmd>Oil<cr>', { desc = 'Oil [E]xplorer' })

-- Snippets
vim.keymap.set('n', '<leader>os', '<cmd>source ~/.config/nvim/lua/snippets.lua<cr>', { desc = 'Reload snippets' })
