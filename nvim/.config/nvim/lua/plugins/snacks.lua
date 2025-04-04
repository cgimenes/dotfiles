return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = ' ', key = 'n', desc = 'New File', action = ':ene' },
            { icon = '󰙅 ', key = 'y', desc = 'Yazi', action = ':Yazi' },
            { icon = ' ', key = 'g', desc = 'LazyGit', action = ':lua Snacks.lazygit()' },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { icon = ' ', title = 'Project Recent Files ', file = vim.fn.fnamemodify('.', ':~') },
          { section = 'recent_files', cwd = true, indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
      indent = {
        enabled = true,
        animate = { enabled = false },
      },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
      scope = { enabled = true },
    },
    keys = {
      {
        '<leader>si',
        function()
          Snacks.picker.icons()
        end,
        desc = 'Search Icons',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>n',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>.',
        function()
          Snacks.picker.files {
            hidden = true,
          }
        end,
        desc = 'Find Files',
      },
      {
        '<leader><space>',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Smart Find Files',
      },
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>,',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>s"',
        function()
          Snacks.picker.registers()
        end,
        desc = 'Registers',
      },
      {
        '<leader>J',
        function()
          Snacks.picker.jumps()
        end,
        desc = 'Jumps',
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.recent()
        end,
        desc = 'Recent',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word { hidden = true }
        end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      {
        '<leader>sm',
        function()
          Snacks.picker.man()
        end,
        desc = 'Man Pages',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep { hidden = true }
        end,
        desc = 'Grep',
      },
      {
        '<leader>oc',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = 'Colorschemes',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undo History',
      },
      -- LSP
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = 'Goto Declaration',
      },
      {
        'grr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gri',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        'gO',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>lS',
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
      {
        '<leader>lD',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>ld',
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = 'Buffer Diagnostics',
      },
      {
        '<leader>oF',
        function()
          local icons = require 'mini.icons'
          local entries = vim.fn.getcompletion('', 'filetype')
          entries = vim.tbl_map(function(ft)
            local buficon, hl = icons.get('filetype', ft)
            if not buficon then
              buficon = ' '
            end
            return ft
          end, entries)
          Snacks.select {
            entries,
            {},
            -- format = function(item)
            --   local ret = {}
            --   ret[#ret + 1] = { ('%-' .. 'longest_name' .. 's'):format(item.name), 'SnacksPickerLabel' }
            --   ret[#ret + 1] = { item.text, 'SnacksPickerComment' }
            --   return ret
            -- end,
            function(item)
              vim.cmd(('set filetype=%s'):format(item))
            end,
          }
        end,
        desc = 'Filetypes',
      },
      {
        '<leader>oPt',
        function()
          Snacks.profiler.toggle()
        end,
        desc = 'Toggle Profiler',
      },
      {
        '<leader>oPh',
        function()
          Snacks.profiler.highlight()
        end,
        desc = 'Toggle Profiler Highlights',
      },
      {
        '<leader>oPp',
        function()
          Snacks.profiler.highlight()
        end,
        desc = 'Toggle Profiler Picker',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command
        end,
      })
    end,
  },
}
