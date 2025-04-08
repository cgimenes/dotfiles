return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      preset = "helix",
      delay = 500,
      icons = {
        mappings = false,
      },
      spec = {
        { '<leader>b', group = 'Buffer' },
        { '<leader>c', group = 'Code' },
        { '<leader>cr', group = 'Rails' },
        { '<leader>d', group = 'Debug' },
        { '<leader>f', group = 'Find and Replace' },
        { '<leader>g', group = 'Git' },
        { '<leader>l', group = 'LSP' },
        { '<leader>ln', group = 'Node' },
        { '<leader>o', group = 'Options' },
        { '<leader>oP', group = 'Profiler' },
        { '<leader>p', group = 'Paste' },
        { '<leader>r', group = 'Runner' },
        { '<leader>R', group = 'REST Client' },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Test' },
        { '<leader>td', group = 'Debug Test' },
        { '<leader>w', group = 'Window' },
        { '<leader>y', group = 'Yank' },
      },
    },
  },
}
