return {
  {
    'yioneko/nvim-vtsls',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    keys = {
      { '<leader>lg', '<cmd>VtsExec goto_source_definition<cr>', desc = 'TS: Go to Source Definition' },
      { '<leader>lo', '<cmd>VtsExec organize_imports<cr>', desc = 'TS: Organize Imports' },
    },
  },
}
