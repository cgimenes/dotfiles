return {
  {
    'cbochs/grapple.nvim',
    opts = {
      scope = 'git_branch',
      icons = false,
    },
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>bt', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
      { '<leader><space>', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    },
  },
}
