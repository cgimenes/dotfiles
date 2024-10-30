return {
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ['q'] = 'actions.close',
        ['<C-t>'] = false,
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<M-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<M-s>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
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
