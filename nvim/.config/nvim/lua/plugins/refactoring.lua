return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = true,
    keys = {
      {
        '<leader>lR',
        function()
          require('refactoring').select_refactor()
        end,
        desc = 'Refactor',
        mode = { 'n', 'v' },
      },
    },
  },
}
