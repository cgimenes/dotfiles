vim.pack.add {
  { src = 'https://github.com/folke/lazy.nvim.git' },
}

require('lazy').setup({
  { import = 'plugins' },
}, {
  change_detection = {
    notify = false,
  },
  dev = {
    path = '~/dev/src/github.com/cgimenes',
  },
  performance = {
    rtp = {
      -- disable unused builtin plugins from neovim
      disabled_plugins = {
        'gzip',
        'health',
        'netrw',
        'netrwPlugin',
        'rplugin',
        'tar',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zip',
        'zipPlugin',
      },
    },
  },
})
