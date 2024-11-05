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
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
        go = { 'gofmt' },
        php = { 'pint' },
        sql = { 'sqlfluff', 'sqlfmt', stop_after_first = true },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        javascript = prettier,
        typescript = prettier,
        css = prettier,
        html = prettier,
        json = prettier,
        yaml = prettier,
        markdown = prettier,
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
