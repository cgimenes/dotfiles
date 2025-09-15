local workspaces = {
  {
    name = 'public',
    path = '~/Public/Obsidian',
  },
}

if vim.fn.isdirectory(vim.fn.expand '~/Obsidian') == 1 then
  table.insert(workspaces, {
    name = 'personal',
    path = '~/Obsidian',
  })
end

if vim.fn.isdirectory(vim.fn.expand '~/Documents/Obsidian') == 1 then
  table.insert(workspaces, {
    name = 'work',
    path = '~/Documents/Obsidian',
  })
end

return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    ft = 'markdown',
    cmd = 'Obsidian',
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
      ui = {
        enable = false,
      },
      workspaces = workspaces,
    },
    keys = {
      { '<leader>Of', '<cmd>Obsidian quick_switch<cr>', desc = 'Open Note' },
      { '<leader>Og', '<cmd>Obsidian search<cr>', desc = 'Grep Notes' },
      { '<leader>On', '<cmd>Obsidian new<cr>', desc = 'New Note' },
      { '<leader>Ow', '<cmd>Obsidian workspace<cr>', desc = 'Change Workspace' },
      { '<leader>Oo', '<cmd>Obsidian open<cr>', desc = 'Open in Obsidian' },
    },
  },
}
