vim.pack.add {
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
  'https://github.com/tpope/vim-dotenv',
  'https://github.com/kristijanhusak/vim-dadbod-ui',
}
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
    Count = 'SELECT COUNT(*) FROM {optional_schema}{table}',
    Explain = 'EXPLAIN ANALYZE {last_query}',
  },
}
Map { '<leader>D', '<cmd>tabnew<cr><cmd>silent Dotenv<cr><cmd>DBUI<cr>', desc = 'Open DBUI' }
