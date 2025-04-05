return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 50,
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
        { '<leader>h', group = 'Grapple' },
        { '<leader>l', group = 'LSP' },
        { '<leader>ln', group = 'Node' },
        { '<leader>L', group = 'LeetCode' },
        { '<leader>o', group = 'Options' },
        { '<leader>p', group = 'Paste' },
        { '<leader>r', group = 'Runner' },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Test' },
        { '<leader>w', group = 'Window' },
        { '<leader>y', group = 'Yank' },
      },
    },
  },
}
