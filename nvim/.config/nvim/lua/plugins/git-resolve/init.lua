local M = {}

local on_conflict_detected = function(event)
  if vim.b[event.bufnr].resolve_keymaps_set then return end

  vim.diagnostic.enable(false, { bufnr = event.bufnr })

  vim.keymap.set('n', ']c', function()
    M.next_conflict()
    vim.cmd 'normal! zt'
  end, { desc = 'Next conflict', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', '[c', function()
    M.prev_conflict()
    vim.cmd 'normal! zt'
  end, { desc = 'Previous conflict', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',O', function() M.choose_ours() end, { desc = 'Choose ours', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',T', function() M.choose_theirs() end, { desc = 'Choose theirs', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',B', function() M.choose_both() end, { desc = 'Choose both', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',M', function() M.choose_base() end, { desc = 'Choose base', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',N', function() M.choose_none() end, { desc = 'Choose none', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',o', function() M.show_diff_ours() end, { desc = 'Diff ours', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',t', function() M.show_diff_theirs() end, { desc = 'Diff theirs', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',b', function() M.show_diff_both() end, { desc = 'Diff both', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',v', function() M.show_diff_ours_vs_theirs() end, { desc = 'Diff ours → theirs', buffer = event.bufnr, silent = true })
  vim.keymap.set('n', ',V', function() M.show_diff_theirs_vs_ours() end, { desc = 'Diff theirs → ours', buffer = event.bufnr, silent = true })

  vim.b[event.bufnr].resolve_keymaps_set = true
end
local on_conflicts_resolved = function(event)
  if not vim.b[event.bufnr].resolve_keymaps_set then return end

  vim.diagnostic.enable(true, { bufnr = event.bufnr })

  for _, mapping in ipairs { ']c', '[c', ',O', ',T', ',B', ',M', ',N', ',o', ',t', ',b', ',v', ',V' } do
    if vim.fn.hasmapto(mapping, 'n') > 0 then vim.api.nvim_buf_del_keymap(event.bufnr, 'n', mapping) end
  end

  vim.b[event.bufnr].resolve_keymaps_set = nil
end

-- Default configuration
local config = {
  -- Conflict marker patterns (Lua patterns, must match from start of line)
  markers = {
    ours = '^<<<<<<<+', -- Start of "ours" section
    theirs = '^>>>>>>>+', -- End of "theirs" section
    ancestor = '^|||||||+', -- Start of ancestor/base section (diff3)
    separator = '^=======+$', -- Separator between sections
  },
  -- Callback function called when conflicts are detected
  -- Receives: { bufnr = number, conflicts = table }
  on_conflict_detected = on_conflict_detected,
  -- Callback function called when all conflicts are resolved
  -- Receives: { bufnr = number }
  on_conflicts_resolved = on_conflicts_resolved,
}

--- Set up highlight groups with colours appropriate for the current background
local function setup_highlights()
  local is_dark = vim.o.background == 'dark'

  -- Semantic colours: ours=green, theirs=blue, separator=grey, ancestor=amber
  local colors
  if is_dark then
    colors = {
      -- Marker highlights (bold with stronger colour)
      ours_marker = { bg = '#3d5c3d', bold = true }, -- green tint
      theirs_marker = { bg = '#3d4d5c', bold = true }, -- blue tint
      separator_marker = { bg = '#4a4a4a', bold = true }, -- neutral grey
      ancestor_marker = { bg = '#5c4d3d', bold = true }, -- amber/orange tint
      -- Section highlights (subtle background tint)
      ours_section = { bg = '#2a3a2a' }, -- subtle green
      theirs_section = { bg = '#2a2f3a' }, -- subtle blue
      ancestor_section = { bg = '#3a322a' }, -- subtle amber
    }
  else
    colors = {
      -- Marker highlights (bold with stronger colour)
      ours_marker = { bg = '#a0d0a0', bold = true }, -- saturated green
      theirs_marker = { bg = '#a0c0e0', bold = true }, -- saturated blue
      separator_marker = { bg = '#c0c0c0', bold = true }, -- medium grey
      ancestor_marker = { bg = '#e0c898', bold = true }, -- saturated amber
      -- Section highlights (subtle background tint)
      ours_section = { bg = '#e8f4e8' }, -- very light green
      theirs_section = { bg = '#e8ecf4' }, -- very light blue
      ancestor_section = { bg = '#f4ece8' }, -- very light amber
    }
  end

  -- Set marker highlights with default=true so users can override
  vim.api.nvim_set_hl(0, 'ResolveOursMarker', vim.tbl_extend('force', colors.ours_marker, { default = true }))
  vim.api.nvim_set_hl(0, 'ResolveTheirsMarker', vim.tbl_extend('force', colors.theirs_marker, { default = true }))
  vim.api.nvim_set_hl(0, 'ResolveSeparatorMarker', vim.tbl_extend('force', colors.separator_marker, { default = true }))
  vim.api.nvim_set_hl(0, 'ResolveAncestorMarker', vim.tbl_extend('force', colors.ancestor_marker, { default = true }))

  -- Set section highlights with default=true so users can override
  vim.api.nvim_set_hl(0, 'ResolveOursSection', vim.tbl_extend('force', colors.ours_section, { default = true }))
  vim.api.nvim_set_hl(0, 'ResolveTheirsSection', vim.tbl_extend('force', colors.theirs_section, { default = true }))
  vim.api.nvim_set_hl(0, 'ResolveAncestorSection', vim.tbl_extend('force', colors.ancestor_section, { default = true }))
end

--- Set up matchit integration for % jumping between conflict markers
local function setup_matchit(bufnr)
  -- Add conflict markers to buffer-local matchit patterns
  local match_words = vim.b[bufnr].match_words or ''
  local conflict_pairs = '<<<<<<<:|||||||:=======:>>>>>>>'
  if not match_words:find('<<<<<<<', 1, true) then
    if match_words ~= '' then match_words = match_words .. ',' end
    vim.b[bufnr].match_words = match_words .. conflict_pairs
    vim.b[bufnr].resolve_matchit_set = true
  end
end

--- Remove matchit integration (called when no conflicts remain)
local function remove_matchit(bufnr)
  -- Skip if matchit wasn't set up
  if not vim.b[bufnr].resolve_matchit_set then return end

  -- Remove conflict patterns from match_words
  local match_words = vim.b[bufnr].match_words or ''
  local conflict_pairs = '<<<<<<<:|||||||:=======:>>>>>>>'

  -- Remove the conflict patterns (with or without comma)
  match_words = match_words:gsub(',' .. vim.pesc(conflict_pairs), '')
  match_words = match_words:gsub(vim.pesc(conflict_pairs) .. ',?', '')

  if match_words == '' then
    vim.b[bufnr].match_words = nil
  else
    vim.b[bufnr].match_words = match_words
  end

  vim.b[bufnr].resolve_matchit_set = nil
end

--- Setup function to initialize the plugin
--- @param opts table|nil User configuration options
function M.setup(opts)
  config = vim.tbl_deep_extend('force', config, opts or {})

  -- Set up highlight groups based on current background
  setup_highlights()

  -- Create augroup for plugin autocmds (clear to handle multiple setup() calls)
  local augroup = vim.api.nvim_create_augroup('ResolveConflicts', { clear = true })

  -- Re-apply highlights when colour scheme changes
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = augroup,
    pattern = '*',
    callback = setup_highlights,
  })

  -- Create autocommand to detect conflicts on buffer enter and after external file changes
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufEnter', 'FileChangedShellPost' }, {
    group = augroup,
    pattern = '*',
    callback = function() M.detect_conflicts() end,
  })
end

--- Scan buffer and return list of all conflicts
--- @return table List of conflict tables
local function scan_conflicts()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local conflicts = {}
  local in_conflict = false
  local current_conflict = {}

  for i, line in ipairs(lines) do
    if line:match(config.markers.ours) then
      in_conflict = true
      current_conflict = {
        start = i,
        ours_start = i,
      }
    elseif line:match(config.markers.ancestor) and in_conflict then
      current_conflict.ancestor = i
    elseif line:match(config.markers.separator) and in_conflict then
      current_conflict.separator = i
    elseif line:match(config.markers.theirs) and in_conflict then
      current_conflict.theirs_end = i
      current_conflict['end'] = i
      table.insert(conflicts, current_conflict)
      in_conflict = false
      current_conflict = {}
    end
  end

  return conflicts
end

--- Find conflict at or around the cursor position by scanning the buffer
--- @return table|nil Conflict data or nil if not in a conflict
local function get_current_conflict()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor[1]
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local line_count = #lines

  -- Search backwards for <<<<<<< marker
  local ours_start = nil
  for i = current_line, 1, -1 do
    local line = lines[i]
    if line:match(config.markers.theirs) then
      -- Hit end of a previous conflict, cursor is not in a conflict
      return nil
    elseif line:match(config.markers.ours) then
      ours_start = i
      break
    end
  end

  if not ours_start then return nil end

  -- Search forwards from ours_start for the rest of the markers
  local ancestor = nil
  local separator = nil
  local theirs_end = nil

  for i = ours_start + 1, line_count do
    local line = lines[i]
    if line:match(config.markers.ours) then
      -- Hit start of another conflict, malformed
      return nil
    elseif line:match(config.markers.ancestor) and not separator then
      ancestor = i
    elseif line:match(config.markers.separator) then
      separator = i
    elseif line:match(config.markers.theirs) then
      theirs_end = i
      break
    end
  end

  -- Validate we found a complete conflict
  if not separator or not theirs_end then return nil end

  -- Check cursor is within conflict bounds
  if current_line > theirs_end then return nil end

  return {
    start = ours_start,
    ours_start = ours_start,
    ancestor = ancestor,
    separator = separator,
    theirs_end = theirs_end,
    ['end'] = theirs_end,
  }
end

--- Detect conflicts and highlight them (for display purposes)
function M.detect_conflicts()
  local bufnr = vim.api.nvim_get_current_buf()
  local conflicts = scan_conflicts()

  if #conflicts > 0 then
    vim.notify(string.format('Found %d conflict(s)', #conflicts), vim.log.levels.INFO)
    M.highlight_conflicts(conflicts)

    -- Set up matchit integration
    setup_matchit(bufnr)

    -- Call user hook if defined (protected to prevent errors from breaking plugin)
    if config.on_conflict_detected then
      local ok, err = pcall(config.on_conflict_detected, { bufnr = bufnr, conflicts = conflicts })
      if not ok then vim.notify('Error in on_conflict_detected hook: ' .. tostring(err), vim.log.levels.ERROR) end
    end
  else
    -- Clear highlights if no conflicts
    local ns_id = vim.api.nvim_create_namespace 'resolve_conflicts'
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    -- Remove matchit integration
    remove_matchit(bufnr)

    -- Call user hook if defined (protected to prevent errors from breaking plugin)
    if config.on_conflicts_resolved then
      local ok, err = pcall(config.on_conflicts_resolved, { bufnr = bufnr })
      if not ok then vim.notify('Error in on_conflicts_resolved hook: ' .. tostring(err), vim.log.levels.ERROR) end
    end
  end

  return conflicts
end

--- Highlight conflicts in the current buffer
--- @param conflicts table List of conflicts to highlight
function M.highlight_conflicts(conflicts)
  local bufnr = vim.api.nvim_get_current_buf()
  local ns_id = vim.api.nvim_create_namespace 'resolve_conflicts'

  -- Clear existing highlights
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  for _, conflict in ipairs(conflicts) do
    -- Highlight marker lines
    -- <<<<<<< marker (ours)
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, conflict.ours_start - 1, 0, {
      end_col = 0,
      end_row = conflict.ours_start,
      hl_group = 'ResolveOursMarker',
      hl_eol = true,
    })

    -- ||||||| marker (ancestor) if exists
    if conflict.ancestor then
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, conflict.ancestor - 1, 0, {
        end_col = 0,
        end_row = conflict.ancestor,
        hl_group = 'ResolveAncestorMarker',
        hl_eol = true,
      })
    end

    -- ======= marker (separator)
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, conflict.separator - 1, 0, {
      end_col = 0,
      end_row = conflict.separator,
      hl_group = 'ResolveSeparatorMarker',
      hl_eol = true,
    })

    -- >>>>>>> marker (theirs)
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, conflict.theirs_end - 1, 0, {
      end_col = 0,
      end_row = conflict.theirs_end,
      hl_group = 'ResolveTheirsMarker',
      hl_eol = true,
    })

    -- Highlight content sections
    -- Ours section (between <<<<<<< and ||||||| or =======)
    local ours_end = conflict.ancestor and (conflict.ancestor - 1) or (conflict.separator - 1)
    if ours_end > conflict.ours_start then
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, conflict.ours_start, 0, {
        end_row = ours_end,
        end_col = 0,
        hl_group = 'ResolveOursSection',
        hl_eol = true,
      })
    end

    -- Ancestor section (between ||||||| and =======) if exists
    if conflict.ancestor and conflict.separator - 1 > conflict.ancestor then
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, conflict.ancestor, 0, {
        end_row = conflict.separator - 1,
        end_col = 0,
        hl_group = 'ResolveAncestorSection',
        hl_eol = true,
      })
    end

    -- Theirs section (between ======= and >>>>>>>)
    if conflict.theirs_end - 1 > conflict.separator then
      vim.api.nvim_buf_set_extmark(bufnr, ns_id, conflict.separator, 0, {
        end_row = conflict.theirs_end - 1,
        end_col = 0,
        hl_group = 'ResolveTheirsSection',
        hl_eol = true,
      })
    end
  end
end

--- Navigate to the next conflict
function M.next_conflict()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor[1]
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Search forwards for next <<<<<<< marker
  for i = current_line + 1, #lines do
    if lines[i]:match(config.markers.ours) then
      vim.api.nvim_win_set_cursor(0, { i, 0 })
      return
    end
  end

  vim.notify('No more conflicts', vim.log.levels.INFO)
end

--- Navigate to the previous conflict
function M.prev_conflict()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor[1]
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- If we're inside a conflict, we need to find the start of the *previous* conflict
  -- First, skip backwards past any <<<<<<< on or before current line that we might be inside
  local search_from = current_line - 1

  -- Check if we're inside a conflict by looking for <<<<<<< before us
  for i = current_line, 1, -1 do
    local line = lines[i]
    if line:match(config.markers.ours) then
      -- We found a <<<<<<< - if this is where we are or before, start searching before it
      search_from = i - 1
      break
    elseif line:match(config.markers.theirs) then
      -- We hit end of previous conflict, we're not inside one
      break
    end
  end

  -- Now search backwards for previous <<<<<<< marker
  for i = search_from, 1, -1 do
    if lines[i]:match(config.markers.ours) then
      vim.api.nvim_win_set_cursor(0, { i, 0 })
      return
    end
  end

  vim.notify('No previous conflicts', vim.log.levels.INFO)
end

--- Choose "ours" version of the conflict
function M.choose_ours()
  local conflict = get_current_conflict()
  if not conflict then
    vim.notify('Not in a conflict', vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  -- Note: 1-indexed positions used as 0-indexed start naturally skip the marker line
  -- End before ancestor (diff3) or separator (non-diff3)
  local end_line = conflict.ancestor and (conflict.ancestor - 1) or (conflict.separator - 1)
  local lines = vim.api.nvim_buf_get_lines(bufnr, conflict.ours_start, end_line, false)

  -- Replace the entire conflict with ours section
  vim.api.nvim_buf_set_lines(bufnr, conflict.start - 1, conflict['end'], false, lines)

  M.detect_conflicts()
end

--- Choose "theirs" version of the conflict
function M.choose_theirs()
  local conflict = get_current_conflict()
  if not conflict then
    vim.notify('Not in a conflict', vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  -- Note: 1-indexed separator used as 0-indexed start naturally skips the ======= line
  local lines = vim.api.nvim_buf_get_lines(bufnr, conflict.separator, conflict.theirs_end - 1, false)

  -- Replace the entire conflict with theirs section
  vim.api.nvim_buf_set_lines(bufnr, conflict.start - 1, conflict['end'], false, lines)

  M.detect_conflicts()
end

--- Choose both versions (ours then theirs)
function M.choose_both()
  local conflict = get_current_conflict()
  if not conflict then
    vim.notify('Not in a conflict', vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()

  -- Get ours section (end before ancestor or separator)
  local ours_end = conflict.ancestor and (conflict.ancestor - 1) or (conflict.separator - 1)
  local ours_lines = vim.api.nvim_buf_get_lines(bufnr, conflict.ours_start, ours_end, false)

  -- Get theirs section
  local theirs_lines = vim.api.nvim_buf_get_lines(bufnr, conflict.separator, conflict.theirs_end - 1, false)

  -- Combine both
  local combined = {}
  vim.list_extend(combined, ours_lines)
  vim.list_extend(combined, theirs_lines)

  -- Replace the entire conflict
  vim.api.nvim_buf_set_lines(bufnr, conflict.start - 1, conflict['end'], false, combined)

  M.detect_conflicts()
end

--- Choose neither version (delete the conflict)
function M.choose_none()
  local conflict = get_current_conflict()
  if not conflict then
    vim.notify('Not in a conflict', vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()

  -- Delete the entire conflict
  vim.api.nvim_buf_set_lines(bufnr, conflict.start - 1, conflict['end'], false, {})

  M.detect_conflicts()
end

--- Choose the base/ancestor version (diff3 style only)
function M.choose_base()
  local conflict = get_current_conflict()
  if not conflict then
    vim.notify('Not in a conflict', vim.log.levels.WARN)
    return
  end

  if not conflict.ancestor then
    vim.notify('No base version available (not a diff3-style conflict)', vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  -- Note: 1-indexed ancestor used as 0-indexed start naturally skips the ||||||| line
  local lines = vim.api.nvim_buf_get_lines(bufnr, conflict.ancestor, conflict.separator - 1, false)

  -- Replace the entire conflict with base section
  vim.api.nvim_buf_set_lines(bufnr, conflict.start - 1, conflict['end'], false, lines)

  M.detect_conflicts()
end

local function render_diff(original, modified, multiple)
  local original_buf = vim.api.nvim_create_buf(false, true)
  local modified_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(original_buf, 0, -1, false, original)
  vim.api.nvim_buf_set_lines(modified_buf, 0, -1, false, modified)
  vim.keymap.set('n', 'q', '<cmd>tabclose<cr>', { desc = 'Close diff', buffer = original_buf })
  vim.keymap.set('n', 'q', '<cmd>tabclose<cr>', { desc = 'Close diff', buffer = modified_buf })

  if not multiple then
    vim.cmd 'tabnew'
  else
    vim.cmd '1wincmd w'
    vim.cmd 'split'
  end

  local original_win = vim.api.nvim_get_current_win()
  if not multiple then
    vim.cmd 'vsplit'
  else
    vim.cmd '3wincmd w'
    vim.cmd 'split'
  end
  local modified_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(original_win, original_buf)
  vim.api.nvim_win_set_buf(modified_win, modified_buf)

  local win_opts = { cursorline = true, wrap = false }
  for opt, val in pairs(win_opts) do
    vim.wo[original_win][opt] = val
    vim.wo[modified_win][opt] = val
  end

  local render = require 'codediff.ui.view.render'
  render.compute_and_render(original_buf, modified_buf, original, modified, false, false, original_win, modified_win, true)
end

--- Show diffs in a floating window
--- @param show_base_ours boolean Whether to show base → ours diff
--- @param show_base_theirs boolean Whether to show base → theirs diff
--- @param show_ours_theirs boolean Whether to show ours → theirs diff
--- @param show_theirs_ours boolean Whether to show theirs → ours diff
local function show_diff_internal(show_base_ours, show_base_theirs, show_ours_theirs, show_theirs_ours)
  local conflict = get_current_conflict()
  if not conflict then
    vim.notify('Not in a conflict', vim.log.levels.WARN)
    return
  end

  -- Check if we need diff3 (base comparisons require ancestor)
  if (show_base_ours or show_base_theirs) and not conflict.ancestor then
    vim.notify('Not a diff3-style conflict (no base version)', vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()

  -- Determine which sections we need to extract
  local need_ours = show_base_ours or show_ours_theirs or show_theirs_ours
  local need_base = show_base_ours or show_base_theirs
  local need_theirs = show_base_theirs or show_ours_theirs or show_theirs_ours

  -- Create temporary directory for files
  local tmpdir = vim.fn.tempname()
  vim.fn.mkdir(tmpdir, 'p')

  -- Extract sections to temporary files as needed
  local ours_lines, base_lines, theirs_lines

  if need_ours then
    local ours_end = conflict.ancestor and (conflict.ancestor - 1) or (conflict.separator - 1)
    ours_lines = vim.api.nvim_buf_get_lines(bufnr, conflict.ours_start, ours_end, false)
  end

  if need_base then base_lines = vim.api.nvim_buf_get_lines(bufnr, conflict.ancestor, conflict.separator - 1, false) end

  if need_theirs then theirs_lines = vim.api.nvim_buf_get_lines(bufnr, conflict.separator, conflict.theirs_end - 1, false) end

  local multiple = false
  if show_base_ours then
    render_diff(base_lines, ours_lines, multiple)
    multiple = true
  end

  if show_base_theirs then
    render_diff(base_lines, theirs_lines, multiple)
    multiple = true
  end

  if show_ours_theirs then
    render_diff(ours_lines, theirs_lines, multiple)
    multiple = true
  end

  if show_theirs_ours then
    render_diff(theirs_lines, ours_lines, multiple)
    multiple = true
  end
end

--- Show diff of our changes from base
function M.show_diff_ours() show_diff_internal(true, false, false, false) end

--- Show diff of theirs changes from base
function M.show_diff_theirs() show_diff_internal(false, true, false, false) end

--- Show both diffs (ours and theirs from base)
function M.show_diff_both() show_diff_internal(true, true, false, false) end

--- Show direct diff between ours and theirs (no base required)
function M.show_diff_ours_vs_theirs() show_diff_internal(false, false, true, false) end

--- Show direct diff between theirs and ours (no base required)
function M.show_diff_theirs_vs_ours() show_diff_internal(false, false, false, true) end

return M
