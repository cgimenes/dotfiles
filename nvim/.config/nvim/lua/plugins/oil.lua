return {
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ['q'] = 'actions.close',
        ['<C-r>'] = 'actions.refresh',
      },
      skip_confirm_for_simple_edits = true,
    },
    cmd = 'Oil',
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Oil [E]xplorer' },
    },
  },
}
