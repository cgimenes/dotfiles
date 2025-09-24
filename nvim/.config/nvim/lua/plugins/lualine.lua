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
      results[index] = string.format('%%#TabLineFill# %s. %%#TabLineFill#%s ', index, file_name)
    else
      results[index] = string.format('%%#TabLineSel# %s. %%#TabLineSel#%s ', index, file_name)
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

local debug_mode_enabled = false
vim.api.nvim_create_autocmd('User', {
  pattern = 'DebugModeChanged',
  callback = function(args)
    debug_mode_enabled = args.data.enabled
  end,
})

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
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
          winbar = {
            'help',
            'startify',
            'dashboard',
            'lazy',
            'neo-tree',
            'neogitstatus',
            'NvimTree',
            'Trouble',
            'alpha',
            'lir',
            'Outline',
            'spectre_panel',
            'toggleterm',
            'DressingSelect',
            'better_term',
            'Jaq',
            'harpoon',
            'grapple',
            'dap-repl',
            'dap-terminal',
            'dapui_console',
            'dapui_hover',
            'lab',
            'notify',
            'noice',
            'neotest-summary',
            '',
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
            color = function(tb)
              return debug_mode_enabled and 'lualine_a_replace' or tb
            end,
            padding = 0,
          },
        },
        lualine_b = {
          {
            'mode',
            fmt = function(str)
              return debug_mode_enabled and 'DEBUG' or str
            end,
            color = function(tb)
              return debug_mode_enabled and 'lualine_b_replace' or tb
            end,
          },
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
              return ' recording to ' .. reg
            end,
            color = 'DiagnosticError',
            cond = function()
              return vim.fn.reg_recording() ~= ''
            end,
          },
          { 'overseer' },
        },
        lualine_c = {
          {
            'branch',
            color = function()
              return { fg = Snacks.util.color 'Statement' }
            end,
          },
          { 'filename', path = 1 },
        },
        lualine_x = {
          { 'diagnostics' },
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
                if client.name ~= 'null-ls' and client.name ~= 'copilot' then
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
                language_servers = language_servers .. ' ' .. icons.git.Octoface .. ' '
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
    },
  },
}
