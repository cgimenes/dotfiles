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

-- Bullets
vim.pack.add { 'https://github.com/bullets-vim/bullets.vim' }
vim.g.bullets_enabled_file_types = { 'markdown' }

-- Render Markdown
vim.pack.add { 'https://github.com/OXY2DEV/markview.nvim' }
-- vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }
-- require('render-markdown').setup {
--   completions = { blink = { enabled = true } },
-- }

-- Zk
-- vim.pack.add { 'https://github.com/zk-org/zk-nvim' }
-- require('zk').setup {
--   picker = 'snacks_picker',
--   picker_options = {
--     snacks_picker = {
--       layout = {
--         preset = 'default',
--       },
--     },
--   },
-- }

-- Obsidian
-- vim.pack.add {
--   { src = 'https://github.com/obsidian-nvim/obsidian.nvim', version = vim.version.range '*' },
-- }
-- require('obsidian').setup {
--   legacy_commands = false,
--   ui = { enable = false }, -- using render-markdown.nvim instead
--   workspaces = workspaces,
--   daily_notes = {
--     folder = 'Dailies',
--     default_tags = {},
--     workdays_only = false,
--   },
-- }
-- Map { '<leader>Of', '<cmd>Obsidian quick_switch<cr>', desc = 'Open Note' }
-- Map { '<leader>Og', '<cmd>Obsidian search<cr>', desc = 'Grep Notes' }
-- Map { '<leader>On', '<cmd>Obsidian new<cr>', desc = 'New Note' }
-- Map { '<leader>Ow', '<cmd>Obsidian workspace<cr>', desc = 'Change Workspace' }
-- Map { '<leader>Oo', '<cmd>Obsidian open<cr>', desc = 'Open in Obsidian' }
-- vim.opt.conceallevel = 1 -- Enable conceal
