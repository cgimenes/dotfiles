local M = {}

function M.find_refs(text)
  local refs = {}
  local seen = {}
  local matched_ranges = {} -- Track matched ranges to avoid overlapping matches

  -- Helper: check if a range overlaps with any existing matched range
  local function is_range_matched(s, e)
    for _, range in ipairs(matched_ranges) do
      -- Check for overlap: not (e < range.s or s > range.e)
      if not (e < range.s or s > range.e) then return true end
    end
    return false
  end

  -- Helper: check if position is visible on screen and add to refs
  local function try_add_ref(path, lnum, display, s, e, ref_type, column)
    -- Skip if this range overlaps with an already matched range
    if is_range_matched(s, e) then return end

    if not seen[display] then
      seen[display] = true
      table.insert(matched_ranges, { s = s, e = e })
      table.insert(refs, {
        path = path,
        line = lnum,
        column = column,
        display = display,
        type = ref_type,
      })
    end
  end

  -- Pattern: file:line:col (must be before file:line to match first)
  local pattern_with_line_col = '([~%.%w/_%-][~%w%./_%-]*):(%d+):(%d+)'
  local search_start = 1
  while true do
    local s, e, path, lnum, cnum = text:find(pattern_with_line_col, search_start)
    if not s then break end
    if not path:match '^%d+$' and #path >= 2 then
      try_add_ref(path, tonumber(lnum), path .. ':' .. lnum .. ':' .. cnum, s, e, 'file', tonumber(cnum))
    end
    search_start = e + 1
  end

  -- Pattern: file:line
  local pattern_with_line = '([~%.%w/_%-][~%w%./_%-]*):(%d+)'
  search_start = 1
  while true do
    local s, e, path, lnum = text:find(pattern_with_line, search_start)
    if not s then break end
    if not path:match '^%d+$' and #path >= 2 then
      try_add_ref(path, tonumber(lnum), path .. ':' .. lnum, s, e, 'file')
    end
    search_start = e + 1
  end

  -- Pattern: file only (without line number)
  local pattern_file_only = '([~%.%w/_%-][~%w%./_%-]*)'
  search_start = 1
  while true do
    local s, e, path = text:find(pattern_file_only, search_start)
    if not s then break end
    local next_chars = text:sub(e + 1, e + 2)
    local looks_like_path = path:match '/' or path:match '%.'
    if not next_chars:match '^:%d' and #path >= 2 and looks_like_path then try_add_ref(path, 1, path, s, e, 'file') end
    search_start = e + 1
  end

  return refs
end

return M
