return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
      -- JSON schemas
      'b0o/schemastore.nvim',
    },
    config = function()
      require('mason-lspconfig').setup()
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
    end,
  },
  {
    'Bekaboo/dropbar.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  },
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },
}
