return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
    },
    keys = {
      { '<leader>D', '<cmd>tabnew<cr><cmd>Dotenv<cr><cmd>DBUI<cr>', desc = 'Open DBUI in a new tab' },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_use_nvim_notify = 1
      vim.g.db_ui_env_variable_url = 'DATABASE_URL'
      vim.g.db_ui_disable_mappings_dbout = 1
      vim.g.db_ui_disable_mappings_sql = 1
      vim.g.db_ui_disable_mappings_javascript = 1
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_hide_schemas = { 'pg_catalog', 'pg_toast' }
      vim.g.db_ui_table_helpers = {
        postgresql = {
          Count = 'select count(*) from {optional_schema}{table}',
          Explain = 'EXPLAIN ANALYZE {last_query}',
        },
      }
    end,
  },
  {
    'tpope/vim-dotenv',
  },
}
