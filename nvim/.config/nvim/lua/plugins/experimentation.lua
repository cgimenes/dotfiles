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
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    ft = 'markdown',
    cmd = "Obsidian",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = 'personal',
          path = '~/Obsidian',
        },
        -- {
        --   name = 'work',
        --   path = '~/Public/Obsidian',
        -- },
      },
    },
  },
}
