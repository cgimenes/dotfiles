return {
  {
    'cbochs/grapple.nvim',
    opts = {
      scope = 'git_branch',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>bm', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
      { '<leader><cr>', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    },
  },
}
