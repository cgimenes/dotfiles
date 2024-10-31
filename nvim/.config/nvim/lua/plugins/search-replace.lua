return {
  {
    'MagicDuck/grug-far.nvim',
    keys = {
      { '<leader>rg', ':GrugFar<cr>', desc = 'Find and [R]eplace using [g]rug-far', mode = { 'v', 'n' } },
    },
    opts = {
      transient = true,
    },
  },
}
