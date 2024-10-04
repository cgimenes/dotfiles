return {
  {
    -- highlight for Window separator
    'nvim-zh/colorful-winsep.nvim',
    opts = {
      hi = {
        fg = '#FFA066',
      },
    },
    event = { 'WinLeave' },
  },
}
