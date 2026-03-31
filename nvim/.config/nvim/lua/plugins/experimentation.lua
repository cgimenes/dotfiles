-- CSV viewer
vim.pack.add { 'https://github.com/hat0uma/csvview.nvim' }
require('csvview').setup()

-- Unstack
vim.pack.add { 'https://github.com/relf108/nvim-unstack' }
require('nvim-unstack').setup {
  mapkey = '<leader>U',
  layout = 'tab',
}

-- Neogit
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/NeogitOrg/neogit',
}
Map { '<leader>gG', '<cmd>Neogit<cr>', desc = 'Neogit' }

-- Markdown
-- vim.pack.add { 'https://github.com/OXY2DEV/markview.nvim' }
vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }
--
-- require('markview').setup {
--   markdown = { enable = false },
--   markdown_inline = { enable = false },
-- }
require('render-markdown').setup {
  enabled = true,
  anti_conceal = { enabled = false },
}

vim.pack.add { 'https://github.com/gbprod/yanky.nvim' }
require('yanky').setup {
  highlight = { timer = 150 },
}
Map {
  'y',
  '<Plug>(YankyYank)',
  mode = { 'n', 'x' },
  desc = 'Yank text',
}
Map {
  'p',
  '<Plug>(YankyPutAfter)',
  mode = { 'n', 'x' },
  desc = 'Put yanked text after cursor',
}
Map {
  'P',
  '<Plug>(YankyPutBefore)',
  mode = { 'n', 'x' },
  desc = 'Put yanked text before cursor',
}
Map {
  'gp',
  '<Plug>(YankyGPutAfter)',
  mode = { 'n', 'x' },
  desc = 'Put yanked text after cursor and leave cursor after',
}
Map {
  'gP',
  '<Plug>(YankyGPutBefore)',
  mode = { 'n', 'x' },
  desc = 'Put yanked text before cursor and leave cursor after',
}
