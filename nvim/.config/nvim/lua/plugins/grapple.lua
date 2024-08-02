return {
  {
    'cbochs/grapple.nvim',
    opts = {
      scope = 'git_branch',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = 'Grapple',
    keys = {
      { '<leader>ht', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
      { '<leader>hm', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
      { '<leader>hn', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
      { '<leader>hp', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
      { '<leader>h1', '<cmd>Grapple select index=1<cr>', desc = 'Select first tag' },
      { '<leader>h2', '<cmd>Grapple select index=2<cr>', desc = 'Select second tag' },
      { '<leader>h3', '<cmd>Grapple select index=3<cr>', desc = 'Select third tag' },
      { '<leader>h4', '<cmd>Grapple select index=4<cr>', desc = 'Select fourth tag' },
      { '<leader>h5', '<cmd>Grapple select index=5<cr>', desc = 'Select fifth tag' },
      { '<leader>h6', '<cmd>Grapple select index=6<cr>', desc = 'Select sixth tag' },
      { '<leader>h7', '<cmd>Grapple select index=7<cr>', desc = 'Select seventh tag' },
      { '<leader>h8', '<cmd>Grapple select index=8<cr>', desc = 'Select eighth tag' },
      { '<leader>h9', '<cmd>Grapple select index=9<cr>', desc = 'Select nineth tag' },
    },
  },
}
