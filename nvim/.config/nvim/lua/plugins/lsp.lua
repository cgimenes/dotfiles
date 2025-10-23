vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' }
vim.lsp.enable {
  'clangd',
  'cssls',
  'emmet_language_server',
  'gopls',
  'intelephense',
  'jsonls',
  'lua_ls',
  'prismals',
  'pyright',
  'ruby_lsp',
  'ruff',
  'tailwindcss',
  'taplo', -- TOML
  'yamlls',
}

-- JSON schemas
vim.pack.add { 'https://github.com/b0o/schemastore.nvim' }

-- Typescript LSP
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/pmizio/typescript-tools.nvim',
}
require('typescript-tools').setup {}
Map { '<leader>lg', '<cmd>TSToolsGoToSourceDefinition<cr>', desc = 'TS: Go to Source Definition' }
Map { '<leader>lo', '<cmd>TSToolsOrganizeImports<cr>', desc = 'TS: Organize Imports' }

-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
-- used for completion, annotations and signatures of Neovim apis
vim.pack.add { 'https://github.com/folke/lazydev.nvim' }
require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    { path = 'snacks.nvim', words = { 'Snacks' } },
  },
}

-- Breadcrumbs
vim.pack.add { 'https://github.com/Bekaboo/dropbar.nvim' }
