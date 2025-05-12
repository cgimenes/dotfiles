local prettier = { 'prettierd', 'prettier', stop_after_first = true }

return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>lf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = false,
      formatters_by_ft = {
        css = prettier,
        cucumber = { 'reformat-gherkin' },
        eruby = { 'erb_format' },
        go = { 'gofmt' },
        html = prettier,
        http = { 'kulala-fmt' },
        javascript = prettier,
        javascriptreact = prettier,
        json = prettier,
        lua = { 'stylua' },
        markdown = prettier,
        php = { 'pint' },
        python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
        rest = { 'kulala-fmt' },
        ruby = { 'rubocop' },
        sh = { 'shfmt' },
        sql = { 'sleek', 'sqlfluff', 'sqlfmt', stop_after_first = true },
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
    },
    config = function(_, opts)
      require('conform').setup(opts)

      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
