local window = require 'plugins.path-warp.window'
local finder = require 'plugins.path-warp.finder'

vim.api.nvim_create_user_command('OpenPathOnWindow', function()
  local buf = vim.api.nvim_get_current_buf()
  local current_line_number = vim.fn.line '.'
  local first = current_line_number - 1
  local last = current_line_number + 1
  local lines = vim.api.nvim_buf_get_lines(buf, first, last, false)
  local line = table.concat(lines, '')

  local refs = finder.find_refs(line)

  if #refs == 0 then
    print 'No file references found'
    return
  end

  if #refs > 1 then print 'Multiple file references found, opening first one' end

  local path = refs[1].path
  local linen = refs[1].line
  local coln = refs[1].column

  local full_path = vim.fs.normalize(vim.fs.joinpath(vim.fn.getcwd(), path))
  if not vim.uv.fs_stat(full_path) and vim.uv.fs_stat(path) then full_path = vim.fs.normalize(path) end
  if not vim.uv.fs_stat(full_path) then
    print 'Referenced file does not exist'
    return
  end

  window.open_in_target_window(path, linen, coln)
end, {})
