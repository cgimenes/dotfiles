return {
  {
    'vim-test/vim-test',
    dependencies = {
      'preservim/vimux',
    },
    config = function()
      vim.cmd("let test#strategy = 'vimux'")
    end,
    keys = {
      { '<leader>tn', '<cmd>TestNearest<cr>', desc = '[T]est [N]earest' },
      { '<leader>tf', '<cmd>TestFile<cr>', desc = '[T]est [F]ile' },
      { '<leader>ts', '<cmd>TestSuite<cr>', desc = '[T]est [S]uite' },
      { '<leader>tl', '<cmd>TestLast<cr>', desc = '[T]est [L]ast' },
      { '<leader>tv', '<cmd>TestVisit<cr>', desc = '[T]est [V]isit' },
    }
  },
}
