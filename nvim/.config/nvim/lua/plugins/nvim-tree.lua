return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function ()
      local on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local openfile = require'nvim-tree.actions.node.open-file'
        local actions = require'telescope.actions'
        local action_state = require'telescope.actions.state'

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        local view_selection = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local filename = selection.filename
            if (filename == nil) then
              filename = selection[1]
            end
            openfile.fn('preview', filename)
          end)
          return true
        end

        function launch_live_grep(opts)
          return launch_telescope("live_grep", opts)
        end

        function launch_find_files(opts)
          return launch_telescope("find_files", opts)
        end

        function launch_telescope(func_name, opts)
          local telescope_status_ok, _ = pcall(require, "telescope")
          if not telescope_status_ok then
            return
          end
          local node = api.tree.get_node_under_cursor()
          local is_folder = node.fs_stat and node.fs_stat.type == 'directory' or false
          local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
          if (node.name == '..' and TreeExplorer ~= nil) then
            basedir = TreeExplorer.cwd
          end
          opts = opts or {}
          opts.cwd = basedir
          opts.search_dirs = { basedir }
          opts.attach_mappings = view_selection
          return require("telescope.builtin")[func_name](opts)
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', 'l', api.node.open.edit, opts "Open")
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts "Close Directory")
        vim.keymap.set('n', '<bs>', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', '<C-r>', api.tree.change_root_to_node, opts('CD'))

        vim.keymap.set('n', '<c-f>', launch_find_files, opts('Launch Find Files'))
        vim.keymap.set('n', '<c-g>', launch_live_grep,  opts('Launch Live Grep'))
      end

      require('nvim-tree').setup({
        on_attach = on_attach,
        view = {
          adaptive_size = true,
        },
        update_focused_file = {
          enable = true,
        },
        git = {
          enable = false,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })

      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Tree [E]xplorer' })
    end
  }
}
