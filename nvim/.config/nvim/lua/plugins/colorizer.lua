vim.pack.add { 'https://github.com/uga-rosa/ccc.nvim' }
require('ccc').setup {}
Map { '<leader>oh', '<cmd>CccHighlighterToggle<cr>', desc = 'Toggle Color Highlight' }
