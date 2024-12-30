return {
  {
    -- Cool icons
    'nvim-tree/nvim-web-devicons',
  },
  {
    -- Better quickfix window
    'yorickpeterse/nvim-pqf',
    event = 'VeryLazy',
    opts = {
      show_multiple_lines = true,
      max_filename_length = 40,
    },
  },
  {
    -- Highlight for Window separator
    'nvim-zh/colorful-winsep.nvim',
    opts = {
      hi = {
        fg = '#FFA066',
      },
    },
    event = { 'WinLeave' },
  },
  {
    -- Better vim.select
    'stevearc/dressing.nvim',
    opts = {
      input = {
        enabled = false,
      },
      select = {
        backend = { 'fzf_lua' },
      },
    },
  },
}
