vim.pack.add { 'https://github.com/MagicDuck/grug-far.nvim' }
require('grug-far').setup { transient = true }
Map { '<leader>fg', ':GrugFar<cr>', desc = 'Find and Replace using grug-far', mode = { 'v', 'n' } }
