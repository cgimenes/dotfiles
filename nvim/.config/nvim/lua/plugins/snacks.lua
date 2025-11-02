local function stop_insert()
  vim.cmd.stopinsert()
end

vim.pack.add { 'https://github.com/folke/snacks.nvim' }
require('snacks').setup {
  bigfile = {
    enabled = true,
    size = 4 * 1024 * 1024, -- 4.0MB
    line_length = 1000, -- average line length (useful for minified files)
  },
  gitbrowse = { what = 'file' },
  dashboard = {
    enabled = true,
    preset = {
      keys = {
        { icon = ' ', key = ',c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
        { icon = ' ', key = ',p', desc = 'Pack', action = ':lua vim.pack.update()' },
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
      { section = 'startup', enabled = package.loaded.lazy ~= nil },
    },
  },
  indent = { enabled = true, animate = { enabled = false } },
  input = { enabled = true },
  notifier = { enabled = true, timeout = 3000 },
  statuscolumn = { folds = { open = true, git_hl = true } },
  picker = {
    enabled = true,
    layout = {
      preset = 'ivy',
      cycle = true,
      hidden = { 'preview' },
    },
    matcher = { frecency = true },
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
}

Map {
  '<leader>si',
  function()
    Snacks.picker.icons()
  end,
  desc = 'Search Icons',
}
Map {
  '<leader>sl',
  function()
    Snacks.picker.resume()
  end,
  desc = 'Resume',
}
Map {
  '<leader>n',
  function()
    Snacks.notifier.show_history()
  end,
  desc = 'Notification History',
}
Map {
  '<leader>gg',
  function()
    Snacks.lazygit()
  end,
  desc = 'Lazygit',
}
Map {
  '<leader>gs',
  function()
    Snacks.picker.git_status { on_show = stop_insert }
  end,
  desc = 'Git Status',
}
Map {
  '<leader>gl',
  function()
    Snacks.picker.git_log()
  end,
  desc = 'Git Log',
}
Map {
  '<leader>gB',
  function()
    Snacks.gitbrowse()
  end,
  desc = 'Git Browse',
  mode = { 'n', 'v' },
}
Map {
  '<leader>/',
  function()
    Snacks.picker.pick()
  end,
  desc = 'Pick Picker',
}
Map {
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
}
Map {
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
}
Map {
  '<leader>:',
  function()
    Snacks.picker.command_history()
  end,
  desc = 'Command History',
}
Map {
  '<leader>,',
  function()
    Snacks.picker.buffers {
      on_show = stop_insert,
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
}
Map {
  '<leader>s"',
  function()
    Snacks.picker.registers { layout = 'vertical', on_show = stop_insert }
  end,
  desc = 'Registers',
}
Map {
  '<leader>J',
  function()
    Snacks.picker.jumps { layout = 'vertical' }
  end,
  desc = 'Jumps',
}
Map {
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
}
Map {
  '<leader>sh',
  function()
    Snacks.picker.help()
  end,
  desc = 'Help Pages',
}
Map {
  '<leader>sk',
  function()
    Snacks.picker.keymaps()
  end,
  desc = 'Keymaps',
}
Map {
  '<leader>sw',
  function()
    Snacks.picker.grep_word { hidden = true }
  end,
  desc = 'Visual selection or word',
  mode = { 'n', 'x' },
}
Map {
  '<leader>sm',
  function()
    Snacks.picker.man()
  end,
  desc = 'Man Pages',
}
Map {
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
}
Map {
  '<leader>oc',
  function()
    Snacks.picker.colorschemes {
      layout = {
        config = function(layout)
          layout.hidden = {}
        end,
      },
      win = {
        preview = {
          max_width = 0,
        },
      },
    }
  end,
  desc = 'Colorschemes',
}
Map {
  '<leader>su',
  function()
    Snacks.picker.undo { on_show = stop_insert }
  end,
  desc = 'Undo History',
}
Map {
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
    }
  end,
  desc = 'Filetypes',
}
-- LSP
Map {
  'gd',
  function()
    Snacks.picker.lsp_definitions()
  end,
  desc = 'Goto Definition',
}
Map {
  'gD',
  function()
    Snacks.picker.lsp_declarations()
  end,
  desc = 'Goto Declaration',
}
Map {
  'grr',
  function()
    Snacks.picker.lsp_references { on_show = stop_insert }
  end,
  nowait = true,
  desc = 'References',
}
Map {
  'gri',
  function()
    Snacks.picker.lsp_implementations()
  end,
  desc = 'Goto Implementation',
}
Map {
  'grI',
  function()
    Snacks.picker.lsp_incoming_calls()
  end,
  desc = 'Incoming Calls',
}
Map {
  'grO',
  function()
    Snacks.picker.lsp_outgoing_calls()
  end,
  desc = 'Outgoing Calls',
}
Map {
  'grt',
  function()
    Snacks.picker.lsp_type_definitions()
  end,
  desc = 'Goto T[y]pe Definition',
}
Map {
  'gO',
  function()
    Snacks.picker.lsp_symbols()
  end,
  desc = 'LSP Symbols',
}
Map {
  'gW',
  function()
    Snacks.picker.lsp_workspace_symbols()
  end,
  desc = 'LSP Workspace Symbols',
}
Map {
  '<leader>lD',
  function()
    Snacks.picker.diagnostics { on_show = stop_insert }
  end,
  desc = 'Diagnostics',
}
Map {
  '<leader>ld',
  function()
    Snacks.picker.diagnostics_buffer { on_show = stop_insert }
  end,
  desc = 'Buffer Diagnostics',
}
-- Profiler
Map {
  '<leader>oPt',
  function()
    Snacks.profiler.toggle()
  end,
  desc = 'Toggle Profiler',
}
Map {
  '<leader>oPh',
  function()
    Snacks.profiler.highlight()
  end,
  desc = 'Toggle Profiler Highlights',
}
Map {
  '<leader>oPp',
  function()
    Snacks.profiler.highlight()
  end,
  desc = 'Toggle Profiler Picker',
}

-- Setup some globals for debugging (lazy-loaded)
_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end
-- Override print to use snacks for `:=` command
if vim.fn.has 'nvim-0.11' == 1 then
  vim._print = function(_, ...)
    dd(...)
  end
else
  vim.print = _G.dd
end

-- Toggle
Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>os'
Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>ow'
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>ol'
