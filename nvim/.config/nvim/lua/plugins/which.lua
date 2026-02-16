vim.pack.add { 'https://github.com/folke/which-key.nvim' }
require('which-key').setup {
  preset = 'helix',
  delay = 500,
  icons = {
    mappings = false,
  },
  spec = {
    { '<leader>a', group = 'AI' },
    { '<leader>c', group = 'Code' },
    { '<leader>d', group = 'Debug' },
    { '<leader>f', group = 'Find and Replace' },
    { '<leader>g', group = 'Git' },
    { '<leader>G', group = 'Github PRs' },
    { '<leader>h', group = 'Git Hunk' },
    { '<leader>H', group = 'HTTP Client' },
    { '<leader>l', group = 'LSP' },
    { '<leader>o', group = 'Options' },
    { '<leader>oP', group = 'Profiler' },
    { '<leader>O', group = 'Obsidian' },
    { '<leader>p', group = 'Paste' },
    { '<leader>r', group = 'Runner' },
    { '<leader>s', group = 'Search' },
    { '<leader>S', group = 'Snippets' },
    { '<leader>t', group = 'Test' },
    { '<leader>w', group = 'Window' },
  },
}
