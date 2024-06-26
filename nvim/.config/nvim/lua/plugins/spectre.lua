return {
  {
    'nvim-pack/nvim-spectre',
    build = false,
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
      {
        '<leader>rs',
        function()
          require('spectre').open()
        end,
        desc = '[R]eplace in files ([S]pectre)',
      },
    },
  },
}
