return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = {
        enabled = true,
        size = 4 * 1024 * 1024, -- 4.0MB
        line_length = 1000, -- average line length (useful for minified files)
      },
      gitbrowse = {
        what = 'file',
      },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = ' ', key = ',n', desc = 'New File', action = ':ene' },
            { icon = ' ', key = ',f', desc = 'Find Files', action = '<leader>sf' },
            { icon = ' ', key = ',y', desc = 'Yazi', action = '-' },
            { icon = ' ', key = ',g', desc = 'LazyGit', action = '<leader>gg' },
            { icon = ' ', key = ',p', desc = 'Octo', action = '<leader>gp' },
            { icon = ' ', key = ',o', desc = 'Obsidian', action = ':Obsidian' },
            { icon = ' ', key = ',c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = '󰒲 ', key = ',l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = '󰬔 ', key = ',m', desc = 'Mason', action = ':Mason' },
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
      statuscolumn = {
        folds = {
          open = true,
          git_hl = true,
        },
      },
      picker = {
        -- formatters = {
        --   file = {
        --     filename_first = true, -- display filename before the file path
        --   },
        -- },
        enabled = true,
        layout = {
          preset = 'ivy',
          cycle = true,
        },
        layouts = {
          ivy = {
            hidden = { 'preview' },
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
          relative = 'editor',
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
        '<leader>gl',
        function()
          Snacks.picker.git_log()
        end,
        desc = 'Git Log',
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
          local truncate_width = vim.api.nvim_win_get_width(0) * 0.8
          Snacks.picker.files {
            hidden = true,
            formatters = {
              file = {
                truncate = truncate_width,
              },
            },
          }
        end,
        desc = 'Find Files',
      },
      {
        '<leader>e',
        function()
          Snacks.picker.explorer {
            hidden = true,
            win = {
              list = {
                keys = {
                  ['<Esc>'] = { '', mode = { 'n', 'i' } },
                },
              },
            },
          }
        end,
        desc = 'Explorer',
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
            on_show = function()
              vim.cmd.stopinsert()
            end,
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
          local truncate_width = vim.api.nvim_win_get_width(0) * 0.8
          Snacks.picker.recent {
            formatters = {
              file = {
                truncate = truncate_width,
              },
            },
          }
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
          local truncate_width = vim.api.nvim_win_get_width(0) * 0.8
          Snacks.picker.grep {
            hidden = true,
            exclude = {
              'package-lock.json',
              'pnpm-lock.yaml',
            },
            formatters = {
              file = {
                truncate = truncate_width,
              },
            },
          }
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

          -- Toggle
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>os'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>ow'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>ol'
        end,
      })
    end,
  },
}
