local window_width_limit = 100

local conditions = {
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

local icons = require 'icons'

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        always_show_tabline = false,
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
          { 'mode' },
        },
        lualine_b = {
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
          { 'branch' },
          { 'diagnostics' },
          { 'overseer' },
        },
        lualine_c = {
          { 'filename', path = 1 },
        },
        lualine_x = {
          {
            function()
              local buf_clients = vim.lsp.get_clients { bufnr = 0 }
              if #buf_clients == 0 then
                return 'LSP Inactive'
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
              local language_servers = string.format('[%s]', unique_client_names)

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
              local shiftwidth = vim.api.nvim_buf_get_option(0, 'shiftwidth')
              return icons.ui.Tab .. '  ' .. shiftwidth
            end,
          },
          { 'filetype' },
          { 'encoding', show_bomb = true },
        },
        lualine_y = {
          { 'location' },
        },
        lualine_z = {
          { 'progress', cond = conditions.not_hlsearch },
          { 'searchcount' },
        },
      },
      tabline = {
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
        'nvim-dap-ui',
        'oil',
        'quickfix',
      },
    },
  },
}
