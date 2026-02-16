function Map(opts)
  local mode = opts.mode or 'n'
  local key = opts[1]
  local cmd = opts[2]
  local desc = opts.desc
  vim.keymap.set(mode, key, cmd, { desc = desc })
end

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Close everything (quickfix, location list and diffview)
vim.keymap.set('n', '<C-q>', '<cmd>ccl<cr><cmd>lcl<cr><cmd>diffoff<cr>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')

vim.keymap.set('x', '$', 'g_')

-- Better pasting experience
vim.keymap.set('x', '<leader>pp', '"_dP', { desc = 'Without yanking' })

-- Better insert mode
vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Yank filename
vim.keymap.set('n', 'yfr', '<cmd>let @+ = expand("%:.")<cr>', { desc = 'Yank relative filename' })
vim.keymap.set('n', 'yfF', '<cmd>let @+ = expand("%:p")<cr>', { desc = 'Yank full filename' })
vim.keymap.set('n', 'yff', '<cmd>let @+ = expand("%:t")<cr>', { desc = 'Yank filename' })

-- Mouse support
vim.keymap.set('n', '<C-LeftMouse>', '<LeftMouse>gd')
vim.keymap.set('n', '<X1Mouse>', '<C-o>')
vim.keymap.set('n', '<X2Mouse>', '<C-i>')

-- Tabs
vim.keymap.set('n', 'tn', '<cmd>tabnew<cr>', { desc = 'New tab' })
vim.keymap.set('n', 'tc', '<cmd>tabclose<cr>', { desc = 'Next tab' })
vim.keymap.set('n', 'tH', '<cmd>-tabmove<cr>', { desc = 'Move tab to the left' })
vim.keymap.set('n', 'tL', '<cmd>+tabmove<cr>', { desc = 'Move tab to the right' })

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
vim.keymap.set({ 'n', 'x' }, '<leader>ce', ':.lua<CR>', { desc = 'Execute the current line or selection' })
vim.keymap.set('n', '<leader>cf', '<cmd>source %<CR>', { desc = 'Execute the current file' })

-- Toggle diagnostic virtual text
vim.keymap.set('n', '<leader>od', function()
  vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
end, { desc = 'Toggle Diagnostic virtual text' })

-- LSP
Map { 'grvd', '<cmd>vsplit<cr><cmd>lua vim.lsp.buf.definition()<cr>', desc = 'Goto Definition in a vsplit' }
Map { '<leader>li', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', desc = 'Incoming Calls' }
Map {
  'grn',
  function()
    vim.lsp.buf.rename()
    vim.cmd 'silent wa'
  end,
  desc = 'Rename',
}
Map {
  '<leader>oh',
  function()
    vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled())
  end,
  desc = 'Toggle color highlight',
}

