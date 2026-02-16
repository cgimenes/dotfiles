local window_width_limit = 100

local conditions = {
  show_grapple = function()
    local tags, err = require('grapple').tags()
    if not tags then
      return vim.notify(err, vim.log.levels.ERROR)
    end

    return vim.fn.tabpagenr() == 1 and #tags > 0
  end,
  hide_in_width = function()
    return vim.o.columns > window_width_limit
  end,
  more_than_one_tab = function()
    return vim.fn.tabpagenr '$' > 1
  end,
  not_hlsearch = function()
    if vim.v.hlsearch == 0 then
      return true
    end

    local ok, result = pcall(vim.fn.searchcount, { timeout = 500 })
    if not ok or next(result) == nil then
      return true
    end
  end,
}

local function grapple_files()
  local tags, err = require('grapple').tags()
  if not tags then
    return vim.notify(err, vim.log.levels.ERROR)
  end

  local file_names = {}
  for _, tag in pairs(tags) do
    local file_name = vim.fn.fnamemodify(tag.path, ':t')
    if not file_names[file_name] then
      file_names[file_name] = {}
    end

    table.insert(file_names[file_name], tag)
  end

  local current_file_path = vim.fn.expand '%:p'
  local results = {}
  for index, tag in ipairs(tags) do
    local file_name = vim.fn.fnamemodify(tag.path, ':t')
    if #file_names[file_name] > 1 then
      file_name = vim.fn.fnamemodify(tag.path, ':h:t') .. '/' .. file_name
    end

    if current_file_path == tag.path then
      results[index] = string.format('%%#lualine_a_normal# %s. %%#lualine_a_normal#%s ', index, file_name)
    else
      results[index] = string.format('%%#lualine_c_normal# %s. %%#lualine_c_normal#%s ', index, file_name)
    end
    results[index] = string.format('%%%s@LualineSwitchGrapple@%s%%X', index, results[index])
  end

  return table.concat(results)
end

vim.cmd [[
  function! LualineSwitchGrapple(index, mouseclicks, mousebutton, modifiers)
    execute ":Grapple select index=" .. a:index
  endfunction
]]

local icons = require 'icons'

vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim' }
require('lualine').setup {
  options = {
    always_show_tabline = true,
    globalstatus = true,
    icons_enabled = true,
    theme = 'auto',
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {
      statusline = {
        'snacks_dashboard',
      },
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function()
          return ' '
        end,
        padding = 0,
      },
    },
    lualine_b = {
      { 'mode' },
      {
        function()
          return ('%s %d events'):format(Snacks.profiler.config.icons.status, #Snacks.profiler.core.events)
        end,
        color = 'DiagnosticError',
        cond = function()
          return Snacks.profiler.core.running
        end,
      },
      {
        function()
          local reg = vim.fn.reg_recording()
          return icons.record .. '  recording to ' .. reg
        end,
        color = 'DiagnosticError',
        cond = function()
          return vim.fn.reg_recording() ~= ''
        end,
      },
    },
    lualine_c = {
      {
        'branch',
        color = function()
          return { fg = Snacks.util.color 'Statement' }
        end,
      },
      { 'diagnostics' },
      { 'filename', path = 1 },
    },
    lualine_x = {
      { 'overseer' },
      {
        function()
          local buf_clients = vim.lsp.get_clients { bufnr = 0 }
          if #buf_clients == 0 then
            return 'No LSP'
          end

          local buf_client_names = {}
          local copilot_active = false

          -- add client
          for _, client in pairs(buf_clients) do
            if client.name ~= 'copilot' then
              table.insert(buf_client_names, client.name)
            end

            if client.name == 'copilot' then
              copilot_active = true
            end
          end

          local unique_client_names = table.concat(buf_client_names, ', ')
          local language_servers = 'LSP Inactive'
          if #unique_client_names > 0 then
            language_servers = string.format('[%s]', unique_client_names)
          end

          if copilot_active then
            language_servers = language_servers .. ' ' .. icons.octoface .. ' '
          end

          return language_servers
        end,
        color = function()
          return { fg = Snacks.util.color 'Statement' }
        end,
        cond = conditions.hide_in_width,
      },
      {
        function()
          local shiftwidth = vim.api.nvim_get_option_value('shiftwidth', { scope = 'local' })
          return icons.ui.Tab .. '  ' .. shiftwidth
        end,
      },
      { 'filetype' },
      { 'encoding', show_bomb = true },
    },
    lualine_y = {
      { 'location' },
      { 'progress', cond = conditions.not_hlsearch },
    },
    lualine_z = {
      { 'searchcount' },
    },
  },
  tabline = {
    lualine_c = {
      {
        grapple_files,
        cond = conditions.show_grapple,
      },
    },
    lualine_z = {
      {
        'tabs',
        show_modified_status = false,
        cond = conditions.more_than_one_tab,
        mode = 1,
        tabs_color = { active = 'lualine_a_normal', inactive = 'lualine_c_normal' },
        fmt = function(label, tab)
          local ok, w = pcall(vim.api.nvim_tabpage_get_win, tab.tabId)
          if ok then
            local b = vim.api.nvim_win_get_buf(w)
            local ft = vim.api.nvim_get_option_value('ft', { buf = b })
            if label == '[No Name]' then
              label = ft
            end
            if ft == 'sql' or ft == 'dbui' or ft == 'dbout' then
              label = icons.db .. ' ' .. label
            elseif ft == 'DiffviewFilePanel' or ft == 'DiffviewFiles' or ft == 'NeogitStatus' then
              label = icons.git .. ' ' .. label
            else
              label = require('nvim-web-devicons').get_icon_by_filetype(ft, { default = true }) .. ' ' .. label
            end
          end
          local Str = require 'plenary.strings'
          if Str.strdisplaywidth(label) > 25 then
            -- tab_max_length is supposed to allow that but it didn't seem to work
            label = Str.truncate(label, 25)
          end
          return label
        end,
      },
    },
  },
  extensions = {
    'fugitive',
    'fzf',
    'lazy',
    'man',
    'mason',
    'oil',
    'quickfix',
  },
}
