-- CSV viewer
vim.pack.add { 'https://github.com/hat0uma/csvview.nvim' }
require('csvview').setup()

-- Neogit
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/NeogitOrg/neogit',
}
Map { '<leader>gG', '<cmd>Neogit<cr>', desc = 'Neogit' }

-- Markdown
vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }
require('render-markdown').setup {
  enabled = true,
  anti_conceal = { enabled = false },
}

-- Yanky
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
