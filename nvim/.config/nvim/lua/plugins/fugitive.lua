return {
  {
    'tpope/vim-fugitive',
    config = function ()
      vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiff<cr>', { desc = '[G]it [D]iff' })
      vim.keymap.set('n', '<leader>gb', '<cmd>G blame<cr>', { desc = '[G]it [B]lame' })
    end
  }
}
