local prettier = { 'prettierd', 'prettier', stop_after_first = true }

vim.pack.add { 'https://github.com/stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = true,
  format_on_save = nil,
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
  'Q',
  function()
    if vim.bo.filetype == 'typescript' or vim.bo.filetype == 'typescriptreact' then
      vim.cmd 'TSToolsOrganizeImports'
    end
    require('conform').format { async = true, lsp_format = 'fallback' }
  end,
  mode = '',
  desc = 'Format buffer',
}
