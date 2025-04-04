return {
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ['q'] = 'actions.close',
        ['<C-t>'] = false,
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-/>'] = 'actions.cd',
        ['<M-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<M-h>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
        ['<M-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in a new tab' },
      },
      skip_confirm_for_simple_edits = true,
      view_options = {
        is_hidden_file = function(name)
          return vim.startswith(name, '.') or name == '__pycache__'
        end,
      },
      float = {
        padding = 5,
        max_width = 100,
      },
    },
    cmd = 'Oil',
    keys = {
      { '<leader>-', '<cmd>Oil --float<cr>', desc = 'Oil Explorer' },
    },
  },
  {
    'mikavilpas/yazi.nvim',
    keys = {
      { '-', '<cmd>Yazi<cr>', desc = 'Yazi Explorer' },
    },
    opts = {
      open_for_directories = true,
      keymaps = {
        open_file_in_vertical_split = '<m-v>',
        open_file_in_horizontal_split = '<m-h>',
        open_file_in_tab = '<m-t>',
        grep_in_directory = '<c-g>',
        replace_in_directory = '<c-r>',
        copy_relative_path_to_selected_files = '<c-y>',
        send_to_quickfix_list = '<c-q>',
        change_working_directory = '<c-/>',
      },
      integrations = {
        grep_in_directory = 'snacks.picker',
        grep_in_selected_files = 'snacks.picker',
      },
    },
  },
}
