return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = true,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = {},
      },
      spec = {
        { '<leader>b', group = '[B]uffer' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>f', group = '[F]ile' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Grapple' },
        { '<leader>l', group = '[L]SP' },
        { '<leader>o', group = '[O]ptions' },
        { '<leader>r', group = 'Find and [R]eplace' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]est' },
        { '<leader>w', group = '[W]indow' },
        { '<leader>y', group = '[Y]ank' },
      },
    },
  },
}
