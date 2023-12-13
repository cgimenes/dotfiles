return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function ()
      local on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', 'l', api.node.open.edit, opts "Open")
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts "Close Directory")
        vim.keymap.set('n', '<bs>', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', '<C-r>', api.tree.change_root_to_node, opts('CD'))
      end

      require('nvim-tree').setup({
        on_attach = on_attach,
        view = {
          width = 80,
        },
        update_focused_file = {
          enable = true,
        },
      })

      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Tree [E]xplorer' })
    end
  }
}
