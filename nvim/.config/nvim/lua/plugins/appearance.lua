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
}
