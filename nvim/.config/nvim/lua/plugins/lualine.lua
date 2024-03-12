local window_width_limit = 100

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.o.columns > window_width_limit
  end,
}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function harpoon_files()
  local harpoon = require 'harpoon'
  local marks_length = harpoon:list():length()

  local contents = {}
  local current_file_path = vim.fn.fnamemodify(vim.fn.expand '%:p', ':.')
  for index = 1, marks_length do
    local harpoon_file_path = harpoon:list():get(index).value
    local file_name = harpoon_file_path == '' and '(empty)' or vim.fn.fnamemodify(harpoon_file_path, ':t')

    if current_file_path == harpoon_file_path then
      contents[index] = string.format('%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ', index, file_name)
    else
      contents[index] = string.format('%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ', index, file_name)
    end
    contents[index] = string.format('%%%s@LualineSwitchHarpoon@%s%%X', index, contents[index])
  end

  return table.concat(contents)
end

vim.cmd [[
  function! LualineSwitchHarpoon(index, mouseclicks, mousebutton, modifiers)
    execute ":lua require(\"harpoon\"):list():select(" .. a:index .. ")"
  endfunction
]]

local colors = require 'colors'

local icons = require 'icons'

return {
  {
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        globalstatus = true,
        icons_enabled = true,
        theme = 'auto',
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
              return ' ' .. icons.ui.Target .. ' '
            end,
            padding = { left = 0, right = 0 },
            color = {},
            cond = nil,
          },
        },
        lualine_b = {
          {
            'b:gitsigns_head',
            icon = icons.git.Branch,
            color = { gui = 'bold' },
          },
        },
        lualine_c = {
          {
            'diff',
            source = diff_source,
            symbols = {
              added = icons.git.LineAdded .. ' ',
              modified = icons.git.LineModified .. ' ',
              removed = icons.git.LineRemoved .. ' ',
            },
            padding = { left = 2, right = 1 },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
            cond = nil,
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

              -- -- add formatter
              -- local formatters = require "lvim.lsp.null-ls.formatters"
              -- local supported_formatters = formatters.list_registered(buf_ft)
              -- vim.list_extend(buf_client_names, supported_formatters)
              --
              -- -- add linter
              -- local linters = require "lvim.lsp.null-ls.linters"
              -- local supported_linters = linters.list_registered(buf_ft)
              -- vim.list_extend(buf_client_names, supported_linters)

              local unique_client_names = table.concat(buf_client_names, ', ')
              local language_servers = string.format('[%s]', unique_client_names)

              if copilot_active then
                language_servers = language_servers .. '%#SLCopilot#' .. ' ' .. icons.git.Octoface .. '%*'
              end

              return language_servers
            end,
            color = { gui = 'bold' },
            cond = conditions.hide_in_width,
          },
          {
            function()
              local shiftwidth = vim.api.nvim_buf_get_option(0, 'shiftwidth')
              return icons.ui.Tab .. ' ' .. shiftwidth
            end,
            padding = 1,
          },
          {
            'filetype',
            cond = nil,
            padding = {
              left = 1,
              right = 1,
            },
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
          { harpoon_files },
        },
      },
    },
  },
}
