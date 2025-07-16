return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      gitbrowse = {
        what = 'file',
      },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = ' ', key = 'n', desc = 'New File', action = ':ene' },
            { icon = ' ', key = 'f', desc = 'Find Files', action = ':lua Snacks.picker.files { hidden = true }' },
            { icon = ' ', key = 'y', desc = 'Yazi', action = ':Yazi' },
            { icon = ' ', key = 'g', desc = 'LazyGit', action = ':lua Snacks.lazygit()' },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
        sections = {
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
      picker = {
        formatters = {
          file = {
            filename_first = true, -- display filename before the file path
            -- truncate = 80, -- truncate the file path to (roughly) this length
          },
        },
        enabled = true,
        layout = {
          preset = 'ivy',
          cycle = true,
        },
        layouts = {
          ivy = {
            layout = {
              box = 'vertical',
              backdrop = false,
              row = -1,
              width = 0,
              height = 0.5,
              border = 'top',
              title = ' {title} {live} {flags}',
              title_pos = 'left',
              { win = 'input', height = 1, border = 'bottom' },
              {
                box = 'horizontal',
                { win = 'list', border = 'none' },
                { win = 'preview', title = '{preview}', width = 0.5, border = 'left' },
              },
            },
          },
        },
        matcher = {
          frecency = true,
        },
        win = {
          input = {
            keys = {
              ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
              ['<C-d>'] = { 'preview_scroll_down', mode = { 'n', 'i' } },
              ['<C-u>'] = { 'preview_scroll_up', mode = { 'n', 'i' } },
              ['<C-y>'] = { 'confirm', mode = { 'n', 'i' } },
            },
          },
        },
      },
      quickfile = { enabled = true },
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
        '<leader>gs',
        function()
          Snacks.picker.git_status {
            on_show = function()
              vim.cmd.stopinsert()
            end,
          }
        end,
        desc = 'Git Status',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
        mode = { 'n', 'v' },
      },
      {
        '<leader>/',
        function()
          Snacks.picker.pick()
        end,
        desc = 'Pick Picker',
      },
      {
        '<leader>sf',
        function()
          Snacks.picker.files { hidden = true }
        end,
        desc = 'Find Files',
      },
      -- {
      --   '<leader>.',
      --   function()
      --     Snacks.picker.explorer {
      --       hidden = true,
      --       auto_close = true,
      --     }
      --   end,
      --   desc = 'Find Files',
      -- },
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
          Snacks.picker.buffers {
            on_show = function()
              vim.cmd.stopinsert()
            end,
            win = {
              input = {
                keys = {
                  ['d'] = 'bufdelete',
                },
              },
            },
          }
        end,
        desc = 'Buffers',
      },
      {
        '<leader>s"',
        function()
          Snacks.picker.registers {
            layout = 'vertical',
          }
        end,
        desc = 'Registers',
      },
      {
        '<leader>J',
        function()
          Snacks.picker.jumps {
            layout = 'vertical',
          }
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
          Snacks.picker.undo {
            on_show = function()
              vim.cmd.stopinsert()
            end,
          }
        end,
        desc = 'Undo History',
      },
      {
        '<leader>of',
        function()
          local icons = require 'mini.icons'
          local entries = vim.fn.getcompletion('', 'filetype')
          entries = vim.tbl_map(function(ft)
            local buficon, hl = icons.get('filetype', ft)
            if not buficon then
              buficon = ' '
            end
            return {
              icon = buficon,
              name = ft,
              text = ft,
              hl = hl,
            }
          end, entries)
          Snacks.picker {
            title = 'Filetypes',
            items = entries,
            format = function(item)
              local ret = {}
              ret[#ret + 1] = { item.icon, item.hl }
              ret[#ret + 1] = { '  ', virtual = true }
              ret[#ret + 1] = { item.name, 'SnacksPickerLabel' }
              return ret
            end,
            confirm = function(picker, item)
              picker:close()
              vim.cmd(('set filetype=%s'):format(item.name))
            end,
            layout = 'select',
          }
        end,
        desc = 'Filetypes',
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
          Snacks.picker.lsp_references {
            on_show = function()
              vim.cmd.stopinsert()
            end,
          }
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
        'grt',
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
        'gW',
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
      {
        '<leader>lD',
        function()
          Snacks.picker.diagnostics {
            on_show = function()
              vim.cmd.stopinsert()
            end,
          }
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>ld',
        function()
          Snacks.picker.diagnostics_buffer {
            on_show = function()
              vim.cmd.stopinsert()
            end,
          }
        end,
        desc = 'Buffer Diagnostics',
      },
      -- Profiler
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
