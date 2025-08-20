return {
  {
    -- select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
    -- create cursors vertically with Ctrl-Down/Ctrl-Up
    -- select one character at a time with Shift-Arrows
    -- press n/N to get next/previous occurrence
    -- press [/] to select next/previous cursor
    -- press q to skip current and get next occurrence
    -- press Q to remove current cursor/selection
    -- start insert mode with i,a,I,A
    -- press tab to switch between cursor mode and extend mode
    -- press s to select using vim motions
    'mg979/vim-visual-multi',
  },
  {
    'abecodes/tabout.nvim',
    event = 'InsertCharPre',
    config = true,
  },
  {
    'emmanueltouzery/apidocs.nvim',
    cmd = { 'ApidocsUninstall' },
    config = true,
    keys = {
      { '<leader>sao', '<cmd>ApidocsOpen<cr>', desc = 'Open Api Doc' },
      { '<leader>sag', '<cmd>ApidocsSearch<cr>', desc = 'Grep Api Doc' },
      { '<leader>sai', '<cmd>ApidocsInstall<cr>', desc = 'Install Api Doc' },
    },
  },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    config = function()
      local function h(name)
        return vim.api.nvim_get_hl(0, { name = name })
      end

      -- hl-groups can have any name
      vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('CursorLine').bg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg = h('CursorLine').bg, fg = h('Comment').fg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = h('Function').fg, bg = h('CursorLine').bg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg = h('Type').fg, bg = h('CursorLine').bg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg = h('@keyword').fg, bg = h('CursorLine').bg, italic = true })

      local function text_format(symbol)
        local res = {}

        local round_start = { '', 'SymbolUsageRounding' }
        local round_end = { '', 'SymbolUsageRounding' }

        -- Indicator that shows if there are any other symbols in the same line
        local stacked_functions_content = symbol.stacked_count > 0 and ('+%s'):format(symbol.stacked_count) or ''

        if symbol.references then
          local usage = symbol.references <= 1 and 'usage' or 'usages'
          local num = symbol.references == 0 and 'no' or symbol.references
          table.insert(res, round_start)
          table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
          table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
          table.insert(res, round_end)
        end

        if symbol.definition then
          if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
          end
          table.insert(res, round_start)
          table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
          table.insert(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
          table.insert(res, round_end)
        end

        if symbol.implementation then
          if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
          end
          table.insert(res, round_start)
          table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
          table.insert(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
          table.insert(res, round_end)
        end

        if stacked_functions_content ~= '' then
          if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
          end
          table.insert(res, round_start)
          table.insert(res, { ' ', 'SymbolUsageImpl' })
          table.insert(res, { stacked_functions_content, 'SymbolUsageContent' })
          table.insert(res, round_end)
        end

        return res
      end

      require('symbol-usage').setup {
        vt_position = 'end_of_line',
        text_format = text_format,
      }
    end,
  },
  {
    'chrisgrieser/nvim-dr-lsp',
    event = 'LspAttach',
    opts = {},
  },
  {
    'machakann/vim-swap',
  },
  {
    'stevearc/aerial.nvim',
    priority = 998,
    lazy = false,
    opts = {},
    keys = {
      { 'gO', '<cmd>AerialToggle<cr>', desc = 'LSP Symbols' },
    },
  },
  {
    'folke/edgy.nvim',
    opts = {
      animate = { enabled = false },
      -- exit_when_last = true,
      right = {
        {
          title = 'Outline',
          ft = 'aerial',
          open = 'AerialToggle',
          size = { width = 0.13 },
        },
      },
    },
  },
  {
    'pwntester/octo.nvim',
    cmd = { 'Octo' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/snacks.nvim',
      'echasnovski/mini.icons',
    },
    opts = {
      enable_builtin = true,
      picker = 'snacks',
      use_local_fs = true,
    },
    keys = {
      { '<leader>gp', '<cmd>Octo pr list<cr>', desc = 'List GitHub PRs' },
    },
  },
}
