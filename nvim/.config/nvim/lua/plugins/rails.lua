return {
  {
    -- Extract partials/concerns -> :Extract <file>
    -- Go to file -> gf
    'tpope/vim-rails',
    lazy = false,
    keys = {
      { '<leader>crr', '<cmd>R<cr>', desc = 'Rails Related File' },
    },
  },
  {
    'preservim/vimux',
    keys = {
      { '<leader>crc', '<cmd>VimuxRunCommand("bin/rails c")<cr><cmd>VimuxZoomRunner<cr>', desc = 'Rails Console' },
    },
  },
}
