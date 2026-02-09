vim.api.nvim_create_user_command('FixJson', function()
  vim.cmd 'silent! %s/^"/'
  vim.cmd 'silent! %s/"$/'
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local input = table.concat(lines, '\n')

  -- Wrap input in quotes so jq can parse it as a JSON string
  local wrapped = '"' .. input .. '"'

  local result = vim.system({ 'jq', '-r', 'fromjson' }, { stdin = wrapped, text = true }):wait()

  if result.code ~= 0 then
    vim.notify('jq error:\n' .. (result.stderr or ''), vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result.stdout, '\n', { trimempty = true }))

  vim.bo.filetype = 'json'
end, {})
