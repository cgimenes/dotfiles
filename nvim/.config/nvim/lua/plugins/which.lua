return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      icons = {
        mappings = false,
      },
      spec = {
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>f', group = '[F]ile' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Grapple' },
        { '<leader>l', group = '[L]SP' },
        { '<leader>ln', group = '[N]ode' },
        { '<leader>L', group = '[L]eetCode' },
        { '<leader>o', group = '[O]ptions' },
        { '<leader>p', group = '[P]aste' },
        { '<leader>r', group = 'Find and [R]eplace' },
        { '<leader>R', group = '[R]EST Client' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]est' },
        { '<leader>w', group = '[W]indow' },
        { '<leader>y', group = '[Y]ank' },
      },
    },
  },
}
