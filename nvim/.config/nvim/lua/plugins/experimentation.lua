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
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require('symbol-usage').setup()
    end,
  },
  {
    'machakann/vim-swap',
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    keys = {
      { 'gO', '<cmd>AerialToggle<cr>', desc = 'LSP Symbols' },
    },
  },
  {
    'folke/edgy.nvim',
    opts = {
      animate = { enabled = false },
      -- exit_when_last = true,
      right = {
        {
          title = 'Outline',
          ft = 'aerial',
          open = 'AerialToggle',
          size = { width = 0.13 },
        },
      },
    },
  },
}
