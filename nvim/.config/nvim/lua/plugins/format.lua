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
  '<leader>oad',
  function()
    vim.g.disable_autoformat = true
  end,
  desc = 'Disable autoformatting globally',
}
Map {
  '<leader>oaD',
  function()
    vim.b.disable_autoformat = true
  end,
  desc = 'Disable autoformatting for this buffer',
}
Map {
  '<leader>oae',
  function()
    vim.g.disable_autoformat = false
    vim.b.disable_autoformat = false
  end,
  desc = 'Re-enable autoformatting',
}
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Format before save',
  pattern = '*',
  group = vim.api.nvim_create_augroup('FormatConfig', { clear = true }),
  callback = function(ev)
    if vim.g.disable_autoformat or vim.b[ev.buf].disable_autoformat then
      return
    end
    local conform_opts = { bufnr = ev.buf, lsp_format = 'fallback', timeout_ms = 500 }
    local client = vim.lsp.get_clients({ name = 'typescript-tools', bufnr = ev.buf })[1]
    if not client then
      require('conform').format(conform_opts)
      return
    end

    vim.cmd 'TSToolsOrganizeImports'
    require('conform').format(conform_opts)
  end,
})
