local ensure_installed = {
  'clangd',
  'cssls',
  'emmet_language_server',
  'gopls',
  'intelephense',
  'jsonls',
  'lua_ls',
  'prettier',
  'prettierd',
  'prismals',
  'pyright',
  'reformat-gherkin',
  'ruby_lsp',
  'ruff',
  'ruff',
  'shfmt',
  'sleek',
  'stylua',
  'tailwindcss',
  'taplo',
  'yamlls',

  -- Debug
  'codelldb',
  'debugpy',
  'delve',
  'js-debug-adapter',
  'php-debug-adapter',
}
if vim.fn.executable 'composer' == 1 then
  vim.list_extend(ensure_installed, { 'pint', 'php-cs-fixer' })
end
if vim.fn.executable 'gem' == 1 then
  vim.list_extend(ensure_installed, { 'rubocop', 'erb-formatter', 'ruby_lsp' })
end

return {
  {
    'mason-org/mason.nvim',
    opts = {
      registries = {
        'github:mason-org/mason-registry',
        'lua:my-mason-registry',
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
    },
    opts = {
      ensure_installed = ensure_installed,
    },
  },
}
