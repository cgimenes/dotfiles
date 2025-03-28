return {
  {
    'maskudo/devdocs.nvim',
    dependencies = {
      'folke/snacks.nvim',
    },
    cmd = { 'DevDocs' },
    keys = {
      {
        '<leader>cdo',
        mode = 'n',
        '<cmd>DevDocs get<cr>',
        desc = 'Open Devdocs',
      },
      {
        '<leader>cdi',
        mode = 'n',
        '<cmd>DevDocs install<cr>',
        desc = 'Install Devdocs',
      },
      {
        '<leader>cdd',
        mode = 'n',
        '<cmd>DevDocs delete<cr>',
        desc = 'Delete Devdoc',
      },
    },
    config = true,
  },
}
