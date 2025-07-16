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
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      completions = { blink = { enabled = true } },
    },
  },
  {
    'mechatroner/rainbow_csv',
    ft = { 'csv', 'tsv' },
  },
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },
  {
    'kyoh86/vim-jsonl',
    ft = 'jsonl',
  },
}
