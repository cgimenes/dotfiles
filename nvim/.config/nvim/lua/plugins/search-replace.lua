return {
  {
    'MagicDuck/grug-far.nvim',
    keys = {
      { '<leader>fg', ':GrugFar<cr>', desc = 'Find and Replace using grug-far', mode = { 'v', 'n' } },
    },
    opts = {
      transient = true,
    },
  },
}
