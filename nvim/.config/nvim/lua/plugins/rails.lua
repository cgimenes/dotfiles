return {
  {
    -- Extract partials/concerns -> :Extract <file>
    -- Go to file -> gf
    'tpope/vim-rails',
    ft = 'ruby',
    keys = {
      { '<leader>crr', '<cmd>R<cr>', desc = 'Rails Related File' },
    },
  },
}
