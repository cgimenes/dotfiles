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
    'abecodes/tabout.nvim',
    event = 'InsertCharPre',
    config = true,
  },
  {
    'emmanueltouzery/apidocs.nvim',
    cmd = { 'ApidocsUninstall' },
    config = true,
    keys = {
      { '<leader>sao', '<cmd>ApidocsOpen<cr>', desc = 'Open Api Doc' },
      { '<leader>sag', '<cmd>ApidocsSearch<cr>', desc = 'Grep Api Doc' },
      { '<leader>sai', '<cmd>ApidocsInstall<cr>', desc = 'Install Api Doc' },
    },
  },
  {
    -- gs to enter swap mode
    'machakann/vim-swap',
  },
  {
    'jinh0/eyeliner.nvim',
    opts = {
      dim = true,
      highlight_on_key = true,
    },
  },
  {
    'CRAG666/betterTerm.nvim',
    enabled = false,
    opts = {
      size = 10,
      index_base = 1,
      prefix = 'Terminal',
      new_tab_mapping = '<A-t>',
      jump_tab_mapping = '<A-$tab>',
    },
    keys = {
      {
        '<leader>.',
        function()
          require('betterTerm').open()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<leader>Tt',
        function()
          require('betterTerm').select()
        end,
        desc = 'Select Terminal',
      },
      {
        '<leader>Tr',
        function()
          require('betterTerm').rename()
        end,
        desc = 'Rename Terminal',
      },
    },
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
}
