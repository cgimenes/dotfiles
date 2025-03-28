return {
  {
    -- Cool icons
    'echasnovski/mini.icons',
    main = 'mini.icons',
    version = false,
    config = true,
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
    enabled = false, -- broke after 0.11
    opts = {
      hi = {
        fg = '#FFA066',
      },
      symbols = { '─', '│', '╭', '╮', '╰', '╯' },
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
