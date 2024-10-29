return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
    keys = {
      {
        '<leader>lR',
        function()
          require('refactoring').select_refactor()
        end,
        desc = '[R]efactor',
      },
    },
  },
}
