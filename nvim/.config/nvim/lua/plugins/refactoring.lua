return {
  {
    'ThePrimeagen/refactoring.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup()
      vim.keymap.set({ 'n', 'x' }, '<leader>lr', function()
        require('refactoring').select_refactor()
      end, { desc = '[R]efactor' })
    end,
  },
}
