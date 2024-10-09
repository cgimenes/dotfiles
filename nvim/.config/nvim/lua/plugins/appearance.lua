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
    -- Better cmdline, popupmenu and messages
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      messages = {
        view_search = false,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      {
        'rcarriga/nvim-notify',
        opts = {
          timeout = 2000,
          stages = 'static',
          render = 'wrapped-compact',
          max_width = 50,
        },
      },
    },
    keys = {
      {
        '<leader>N',
        '<cmd>NoiceTelescope<cr>',
        desc = '[N]otification history',
      },
    },
  },
  {
    -- Better vim.select
    'stevearc/dressing.nvim',
    dependencies = {
      'ibhagwan/fzf-lua',
    },
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
