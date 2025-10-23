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

vim.pack.add {
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
}
require('mason').setup {}
require('mason-lspconfig').setup()
require('mason-tool-installer').setup { ensure_installed = ensure_installed }
