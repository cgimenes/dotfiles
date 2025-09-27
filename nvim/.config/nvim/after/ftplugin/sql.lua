vim.keymap.set('n', '<cr>', ':normal vip<CR><Plug>(DBUI_ExecuteQuery)', { buffer = true, desc = 'Run query under cursor' })
vim.keymap.set('v', '<cr>', '<Plug>(DBUI_ExecuteQuery)', { buffer = true, desc = 'Run selected query' })
vim.keymap.set('n', '<localleader>b', '<Plug>(DBUI_EditBindParameters)', { buffer = true, desc = 'Edit bind parameters' })
vim.keymap.set('n', '<localleader>s', '<Plug>(DBUI_SaveQuery)', { buffer = true, desc = 'Save query' })

local function get_dbout_win_buf()
  for _, w in pairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(w)
    if vim.api.nvim_buf_get_option(buf, 'ft') == 'dbout' then
      return vim.api.nvim_win_get_number(w), buf
    end
  end
end
local function jump_to_dbout()
  local dbout_win, dbout_buf = get_dbout_win_buf()
  vim.cmd(dbout_win .. ' wincmd w')
end
vim.keymap.set('n', '<localleader>o', jump_to_dbout, { buffer = true, desc = 'Jump to the SQL output window' })
