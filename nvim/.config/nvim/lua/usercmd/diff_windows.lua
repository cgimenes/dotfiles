vim.api.nvim_create_user_command('DiffWindows', function()
  local files = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    -- We escape the name so spaces don't break the command
    table.insert(files, vim.fn.fnameescape(name))
  end

  -- This builds the string "Cmd file1 file2" and runs it
  vim.cmd('CodeDiff file ' .. table.concat(files, ' '))
end, {})
