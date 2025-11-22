local prettier = { 'prettierd', 'prettier', stop_after_first = true }

vim.pack.add { 'https://github.com/stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = true,
  format_on_save = nil,
  default_format_opts = { lsp_format = 'fallback' },
  formatters_by_ft = {
    css = prettier,
    cucumber = { 'reformat-gherkin' },
    eruby = { 'erb_format' },
    go = { 'gofmt' },
    html = prettier,
    javascript = prettier,
    javascriptreact = prettier,
    json = prettier,
    lua = { 'stylua' },
    markdown = prettier,
    php = { 'pint' },
    python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
    sh = { 'shfmt' },
    sql = { 'sleek' },
    typescript = prettier,
    typescriptreact = prettier,
    yaml = prettier,
    zsh = { 'shfmt' },
  },
  formatters = {
    php_cs_fixer = {
      args = { 'fix', '--config=.php-cs-fixer.dist.php', '--allow-risky=yes', '$FILENAME' },
    },
    sqlfluff = {
      args = { 'fix', '--dialect', 'postgres', '-' },
    },
  },
}
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
Map {
  'gQ',
  function()
    local client = vim.lsp.get_clients({ name = 'typescript-tools' })[1]
    if client then
      require('typescript-tools.api').organize_imports(true)
    end
    require('conform').format {}
  end,
  desc = 'Format entire buffer',
}
