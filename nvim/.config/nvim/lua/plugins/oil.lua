return {
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ["gq"] = "actions.close",
      },
    },
    cmd = 'Oil',
    keys = {
      { "-", '<cmd>Oil<cr>', desc = "Oil [E]xplorer" },
    }
  },
}
