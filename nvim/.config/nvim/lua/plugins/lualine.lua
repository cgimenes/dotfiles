local window_width_limit = 100

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.o.columns > window_width_limit
  end,
  first_tab = function()
    return vim.fn.tabpagenr() == 1
  end,
  more_than_one_tab = function()
    return vim.fn.tabpagenr '$' > 1
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
      results[index] = string.format('%%#GrappleBold# %s. %%#GrappleBold#%s ', index, file_name)
    else
      results[index] = string.format('%%#GrappleHint# %s. %%#GrappleHint#%s ', index, file_name)
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

local colors = require('kanagawa.colors').setup { theme = 'wave' }
local theme = colors.theme
local palette = colors.palette

local icons = require 'icons'

local modes = setmetatable({
  ['n'] = 'N',
  ['no'] = 'N',
  ['v'] = 'V',
  ['V'] = 'VL',
  [''] = 'VB',
  ['s'] = 'S',
  ['S'] = 'SL',
  [''] = 'SB',
  ['i'] = 'I',
  ['ic'] = 'I',
  ['R'] = 'R',
  ['Rv'] = 'VR',
  ['c'] = 'C',
  ['cv'] = 'EX',
  ['ce'] = 'X',
  ['r'] = 'P',
  ['rm'] = 'M',
  ['r?'] = 'C',
  ['!'] = 'SH',
  ['t'] = 'T',
}, {
  __index = function()
    return '-'
  end,
})

return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = function()
          local mode_colors = {
            normal = palette.crystalBlue,
            insert = palette.springGreen,
            visual = palette.surimiOrange,
            replace = palette.waveRed,
            command = palette.autumnYellow,
          }

          return {
            inactive = {
              a = { fg = theme.ui.fg, bg = theme.ui.bg, gui = 'bold' },
              b = { fg = theme.ui.fg, bg = nil },
              c = { fg = theme.ui.fg, bg = nil },
            },
            visual = {
              a = { fg = theme.ui.bg_m3, bg = mode_colors.visual, gui = 'bold' },
              b = { fg = theme.ui.fg, bg = nil },
              c = { fg = theme.ui.fg, bg = nil },
            },
            replace = {
              a = { fg = theme.ui.bg_m3, bg = mode_colors.replace, gui = 'bold' },
              b = { fg = theme.ui.fg, bg = nil },
              c = { fg = theme.ui.fg, bg = nil },
            },
            normal = {
              a = { fg = theme.ui.bg_m3, bg = mode_colors.normal, gui = 'bold' },
              b = { fg = theme.ui.fg, bg = nil },
              c = { fg = theme.ui.fg, bg = nil },
            },
            insert = {
              a = { fg = theme.ui.bg_m3, bg = mode_colors.insert, gui = 'bold' },
              b = { fg = theme.ui.fg, bg = nil },
              c = { fg = theme.ui.fg, bg = nil },
            },
            command = {
              a = { fg = theme.ui.bg_m3, bg = mode_colors.command, gui = 'bold' },
              b = { fg = theme.ui.fg, bg = nil },
              c = { fg = theme.ui.fg, bg = nil },
            },
          }
        end,
        component_separators = '',
        section_separators = '',
        disabled_filetypes = {
          statusline = {
            'dashboard',
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
            function()
              return modes[vim.api.nvim_get_mode().mode]
            end,
            padding = 1,
            color = {},
            cond = nil,
          },
          {
            function()
              local reg = vim.fn.reg_recording()
              if reg == '' then
                return ''
              end
              return 'recording to ' .. reg
            end,
            color = { bg = palette.peachRed, gui = 'bold' },
          },
        },
        lualine_b = {
          {
            'b:gitsigns_head',
            icon = icons.git.Branch,
          },
        },
        lualine_c = {
          {
            function()
              return '%='
            end,
          },
          {
            'filename',
            color = {},
            path = 1,
            cond = nil,
          },
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = {
              error = icons.diagnostics.BoldError .. ' ',
              warn = icons.diagnostics.BoldWarning .. ' ',
              info = icons.diagnostics.BoldInformation .. ' ',
              hint = icons.diagnostics.BoldHint .. ' ',
            },
          },
          {
            function()
              local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
              if #buf_clients == 0 then
                return 'LSP Inactive'
              end

              local buf_ft = vim.bo.filetype
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
              local language_servers = string.format('[%s]', unique_client_names)

              if copilot_active then
                language_servers = language_servers .. ' ' .. icons.git.Octoface .. ' '
              end

              return language_servers
            end,
            color = { gui = 'bold' },
            cond = conditions.hide_in_width,
          },
          {
            function()
              local shiftwidth = vim.api.nvim_buf_get_option(0, 'shiftwidth')
              return icons.ui.Tab .. '  ' .. shiftwidth
            end,
            padding = 1,
          },
          {
            'filetype',
            padding = 1,
          },
          {
            'encoding',
            show_bomb = true,
          },
        },
        lualine_y = {
          {
            'location',
          },
        },
        lualine_z = {
          {
            'searchcount',
          },
        },
      },
      tabline = {
        lualine_a = {
          {
            grapple_files,
            cond = conditions.first_tab,
            padding = 0,
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
    },
  },
}
