return {
  {
    'eraserhd/parinfer-rust',
    build = 'cargo build --release',
    ft = { 'yuck' },
  },
  {
    'fladson/vim-kitty',
    ft = 'kitty',
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = true,
  },
}
