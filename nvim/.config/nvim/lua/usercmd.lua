vim.api.nvim_create_user_command('FixJson', function()
  vim.opt_local.filetype = 'json'

  vim.cmd 'silent! %s/\\\\"/"/g<cr>'
  vim.cmd 'silent! %s/^"//<cr>'
  vim.cmd 'silent! %s/"$//<cr>'
  vim.cmd 'silent! %s/"$//<cr>'
  require('conform').format {}
end, {})

vim.api.nvim_create_user_command('OpenPathOnWindow', function()
  local line = vim.api.nvim_get_current_line()

  local cfile = vim.fn.expand '<cfile>'
  local start_idx = line:find(cfile, 1, true)
  if not start_idx then
    print 'Path not found on current line'
    return
  end
  local trimmed_line = line:sub(start_idx)

  -- Pipe this all into quickfix to take advantage of the errorformatting that it does
  local original_qf_state = vim.fn.getqflist { all = 0 }
  local original_efm = vim.go.errorformat

  local temp_efm = table.concat({
    '%f:%l:%c:%m',
    '%f:%l:%c',
    '%f:%l',
  }, ',')
  vim.go.errorformat = temp_efm .. ',' .. original_efm
  vim.fn.setqflist({}, 'r', { lines = { trimmed_line } })
  local qf_items = vim.fn.getqflist()

  vim.go.errorformat = original_efm
  vim.fn.setqflist({}, 'r', {
    items = original_qf_state.items,
    title = original_qf_state.title,
  })

  local lnum = qf_items[1].lnum
  local col = qf_items[1].col

  local full_path = vim.fs.normalize(vim.fs.joinpath(vim.fn.getcwd(), cfile))
  if not vim.uv.fs_stat(full_path) and vim.uv.fs_stat(cfile) then
    full_path = vim.fs.normalize(cfile)
  end
  if not vim.uv.fs_stat(full_path) then
    return
  end

  local open_to_cmd = 'edit +' .. lnum .. ' ' .. vim.fn.fnameescape(full_path)
  if type(col) == 'number' and col > 0 then
    open_to_cmd = open_to_cmd .. ' | normal! ' .. col .. '|'
  end

  local window = Snacks.picker.util.pick_win()
  vim.fn.win_execute(window, open_to_cmd)
  vim.api.nvim_set_current_win(window)
end, {})
