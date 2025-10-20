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
    -- press tab to switch between cursor mode and extend mode
    -- press s to select using vim motions
    'mg979/vim-visual-multi',
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 10
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        else
          return 20
        end
      end,
      auto_scroll = false,
    },
    keys = {
      { '<leader>.', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
      { '<leader>>', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Toggle Vertical Terminal' },
    },
  },
  {
    'alex-popov-tech/store.nvim',
    opts = {
      plugin_manager = 'lazy.nvim',
    },
    cmd = 'Store',
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
}
