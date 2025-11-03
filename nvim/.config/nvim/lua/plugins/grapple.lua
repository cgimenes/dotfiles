vim.pack.add { 'https://github.com/cbochs/grapple.nvim' }
require('grapple').setup { scope = 'git_branch' }
Map { '<leader>bm', '<cmd>Grapple toggle<cr>', desc = 'Toggle Grapple tag' }
Map { '<leader><cr>', '<cmd>Grapple toggle_tags<cr>', desc = 'Open Grapple' }
Map { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'which_key_ignore' }
Map { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'which_key_ignore' }
Map { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'which_key_ignore' }
Map { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'which_key_ignore' }
Map { '<leader>5', '<cmd>Grapple select index=5<cr>', desc = 'which_key_ignore' }
Map { '<leader>6', '<cmd>Grapple select index=6<cr>', desc = 'which_key_ignore' }
Map { '<leader>7', '<cmd>Grapple select index=7<cr>', desc = 'which_key_ignore' }
Map { '<leader>8', '<cmd>Grapple select index=8<cr>', desc = 'which_key_ignore' }
Map { '<leader>9', '<cmd>Grapple select index=9<cr>', desc = 'which_key_ignore' }
