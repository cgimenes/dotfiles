return {
  {
    -- Cool icons
    'echasnovski/mini.icons',
    main = 'mini.icons',
    version = false,
    config = function()
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
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
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      messages = {
        enabled = true,
        view_search = false,
      },
      popupmenu = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
      presets = {
        command_palette = true,
      },
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == 'lazy' then
        vim.cmd [[messages clear]]
      end
      require('noice').setup(opts)
    end,
  },
  {
    -- Highlight for Window separator
    'nvim-zh/colorful-winsep.nvim',
    opts = {
      hi = {
        fg = '#e6c384',
      },
      symbols = { '─', '│', '╭', '╮', '╰', '╯' },
    },
    event = { 'WinLeave' },
  },
}
