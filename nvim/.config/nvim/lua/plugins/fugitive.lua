return {
  {
    'tpope/vim-fugitive',
    config = function ()
      vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr><C-w>o', { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiff<cr>', { desc = '[G]it [D]iff' })
      vim.keymap.set('n', '<leader>gb', '<cmd>G blame<cr>', { desc = '[G]it [B]lame' })
    end
  }
}
