return {
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>lf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
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
        javascript = { 'prettier' },
      },
      formatters = {
        php_cs_fixer = {
          args = { 'fix', '--config=.php-cs-fixer.dist.php', '--allow-risky=yes', '$FILENAME' },
        },
      },
    },
  },
}
