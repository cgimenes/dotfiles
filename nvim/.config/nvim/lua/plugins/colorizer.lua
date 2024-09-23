return {
  {
    'uga-rosa/ccc.nvim',
    cmd = {
      'CccPick',
      'CccConvert',
      'CccHighlighterEnable',
      'CccHighlighterDisable',
      'CccHighlighterToggle',
    },
    opts = {},
    keys = {
      { '<leader>oh', '<cmd>CccHighlighterToggle<cr>', desc = 'Toggle Color [H]ighlighter' },
    },
  },
}
