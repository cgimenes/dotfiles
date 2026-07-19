vim.pack.add { 'gh:brenoprata10/nvim-highlight-colors' }
require('nvim-highlight-colors').setup {
  render = 'virtual',
  virtual_symbol = '',
  virtual_symbol_position = 'eow',
  virtual_symbol_prefix = ' ',
  virtual_symbol_suffix = '',
}
Map {
  '<leader>oh',
  require('nvim-highlight-colors').toggle,
  desc = 'Toggle Color Highlight',
}
