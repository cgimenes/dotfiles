vim.pack.add { 'https://github.com/folke/flash.nvim' }
require('flash').setup {
  modes = {
    char = {
      enabled = false,
    },
  },
}
Map {
  'zk',
  mode = { 'n', 'x', 'o' },
  function()
    require('flash').jump()
  end,
  desc = 'Flash',
}
Map {
  'Zk',
  mode = { 'n', 'x', 'o' },
  function()
    require('flash').treesitter()
  end,
  desc = 'Flash Treesitter',
}
Map {
  'r',
  mode = 'o',
  function()
    require('flash').remote()
  end,
  desc = 'Remote Flash',
}
