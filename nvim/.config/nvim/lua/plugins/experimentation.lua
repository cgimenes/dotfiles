return {
  {
    -- select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
    -- create cursors vertically with Ctrl-Down/Ctrl-Up
    -- select one character at a time with Shift-Arrows
    -- press n/N to get next/previous occurrence
    -- press [/] to select next/previous cursor
    -- press q to skip current and get next occurrence
    -- press Q to remove current cursor/selection
    -- start insert mode with i,a,I,A
    'mg979/vim-visual-multi',
  },
  {
    '2kabhishek/exercism.nvim',
    keys = {
      { '<leader>el', '<cmd>ExercismLanguages<cr>', desc = 'List Languages' },
      { '<leader>eS', '<cmd>ExercismSubmit<cr>', desc = 'Submit' },
      { '<leader>et', '<cmd>ExercismTest<cr>', desc = 'Test' },
      { '<leader>eL', '<cmd>ExercismList<cr>', desc = 'List Exercises' },
    },
    dependencies = {
      '2kabhishek/utils.nvim', -- required, for utility functions
      '2kabhishek/termim.nvim', -- optional, better UX for running tests
    },
    -- Add your custom configs here, keep it blank for default configs (required)
    opts = {},
  },
  {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>', -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = '`', close = '`' },
          { open = '(', close = ')' },
          { open = '[', close = ']' },
          { open = '{', close = '}' },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      }
    end,
    event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
  },
  {
    'yioneko/nvim-vtsls',
    ft = { 'typescript', 'javascript' },
    keys = {
      { '<leader>cjd', '<cmd>VtsExec goto_source_definition<cr>', desc = 'Go to Source Definition' },
      { '<leader>cjo', '<cmd>VtsExec organize_imports<cr>', desc = 'Organize Imports' },
    },
  },
  {
    'echasnovski/mini.files',
    version = false,
    opts = {
      options = {
        permanent_delete = false,
        use_as_default_explorer = false,
      },
    },
    keys = {
      {
        '<leader>.',
        function()
          if not MiniFiles.close() then
            MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
          end
        end,
        desc = 'Mini Files',
      },
    },
  },
}
