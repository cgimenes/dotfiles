return {
  {
    'yioneko/nvim-vtsls',
    enabled = false,
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    keys = {
      { '<leader>lg', '<cmd>VtsExec goto_source_definition<cr>', desc = 'TS: Go to Source Definition' },
      { '<leader>lo', '<cmd>VtsExec organize_imports<cr>', desc = 'TS: Organize Imports' },
    },
  },
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
    keys = {
      { '<leader>lg', '<cmd>TSToolsGoToSourceDefinition<cr>', desc = 'TS: Go to Source Definition' },
      { '<leader>lo', '<cmd>TSToolsOrganizeImports<cr>', desc = 'TS: Organize Imports' },
    },
  },
}
