return {
  {
    'MagicDuck/grug-far.nvim',
    keys = {
      { '<leader>fg', ':GrugFar<cr>', desc = '[F]ind and Replace using [g]rug-far', mode = { 'v', 'n' } },
    },
    opts = {
      transient = true,
    },
  },
}
