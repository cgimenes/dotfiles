return {
  {
    -- Cool icons
    'nvim-mini/mini.icons',
    main = 'mini.icons',
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
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    opts = {
      preset = 'classic',
      options = {
        show_all_diags_on_cursorline = true,
      },
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
  {
    'folke/edgy.nvim',
    opts = {
      animate = { enabled = false },
      -- exit_when_last = true,
      left = {
        {
          title = 'Find and Replace',
          ft = 'grug-far',
          size = { width = 0.20 },
        },
        {
          title = 'DBUI',
          ft = 'dbui',
          size = { width = 0.20 },
        },
      },
    },
  },
}
