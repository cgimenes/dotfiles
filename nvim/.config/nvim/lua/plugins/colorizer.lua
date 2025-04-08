return {
  {
    'uga-rosa/ccc.nvim',
    cmd = {
      'CccPick',
      'CccConvert',
      'CccHighlighterToggle',
    },
    config = true,
    keys = {
      { '<leader>oh', '<cmd>CccHighlighterToggle<cr>', desc = 'Toggle Color Highlight' },
    },
  },
}
