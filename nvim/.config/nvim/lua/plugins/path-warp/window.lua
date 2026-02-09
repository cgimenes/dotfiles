local M = {}

---Find appropriate target window for opening file
---@return number
M.find_target_window = function()
  local available_windows = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bt = vim.bo[buf].buftype
    local ft = vim.bo[buf].filetype
    local cfg = vim.api.nvim_win_get_config(win)
    if
      (not cfg.relative or cfg.relative == '')
      and bt ~= 'terminal'
      and bt ~= 'prompt'
      and ft ~= 'neo-tree'
      and ft ~= 'NvimTree'
      and ft ~= 'oil'
      and ft ~= 'qf'
    then
      table.insert(available_windows, win)
    end
  end

  if #available_windows == 0 then
    -- TODO create a new window if no suitable windows are found?
    return vim.api.nvim_get_current_win()
  elseif #available_windows == 1 then
    return available_windows[1]
  else
    return Snacks.picker.util.pick_win()
  end
end

M.open_in_target_window = function(full_path, lnum, col)
  local open_to_cmd = 'edit +' .. lnum .. ' ' .. vim.fn.fnameescape(full_path)
  if type(col) == 'number' and col > 0 then open_to_cmd = open_to_cmd .. ' | normal! ' .. col .. '|' end

  local window = M.find_target_window()
  vim.fn.win_execute(window, open_to_cmd)
  vim.api.nvim_set_current_win(window)
end

return M
