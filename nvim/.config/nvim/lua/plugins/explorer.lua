return {
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
        grep_in_directory = function(directory)
          require('fzf-lua').live_grep { cwd = directory }
        end,
      },
    },
  },
}
