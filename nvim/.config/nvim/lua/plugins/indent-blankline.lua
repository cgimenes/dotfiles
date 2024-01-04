return {
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        char = "▏",
      },
      scope = {
        enabled = false,
      }
    },
  },
}
