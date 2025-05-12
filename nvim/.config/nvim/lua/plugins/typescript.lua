return {
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
