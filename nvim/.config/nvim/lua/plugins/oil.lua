return {
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ["q"] = "actions.close",
      },
    },
    cmd = 'Oil',
    keys = {
      { "-", '<cmd>Oil<cr>', desc = "Oil [E]xplorer" },
    }
  },
}
