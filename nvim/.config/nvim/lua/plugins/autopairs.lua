return {
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>op',
        function()
          vim.g.minipairs_disable = not vim.g.minipairs_disable
        end,
        desc = 'Toggle auto pairs',
      },
    },
  },
}
