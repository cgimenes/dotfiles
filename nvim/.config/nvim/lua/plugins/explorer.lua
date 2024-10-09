return {
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ['q'] = 'actions.close',
        ['<C-r>'] = 'actions.refresh',
      },
      skip_confirm_for_simple_edits = true,
      view_options = {
        is_hidden_file = function(name)
          return vim.startswith(name, '.') or name == '__pycache__'
        end,
      },
    },
    cmd = 'Oil',
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Oil [E]xplorer' },
    },
  },
}
