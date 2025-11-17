vim.pack.add { 'https://github.com/cbochs/grapple.nvim' }
require('grapple').setup { scope = 'git_branch' }
Map { 'gm', '<cmd>Grapple toggle<cr>', desc = 'Toggle bookmark' }
Map { 'gl', '<cmd>Grapple toggle_tags<cr>', desc = 'Open bookmark list' }
Map { 'g1', '<cmd>Grapple select index=1<cr>', desc = 'which_key_ignore' }
Map { 'g2', '<cmd>Grapple select index=2<cr>', desc = 'which_key_ignore' }
Map { 'g3', '<cmd>Grapple select index=3<cr>', desc = 'which_key_ignore' }
Map { 'g4', '<cmd>Grapple select index=4<cr>', desc = 'which_key_ignore' }
Map { 'g5', '<cmd>Grapple select index=5<cr>', desc = 'which_key_ignore' }
Map { 'g6', '<cmd>Grapple select index=6<cr>', desc = 'which_key_ignore' }
Map { 'g7', '<cmd>Grapple select index=7<cr>', desc = 'which_key_ignore' }
Map { 'g8', '<cmd>Grapple select index=8<cr>', desc = 'which_key_ignore' }
Map { 'g9', '<cmd>Grapple select index=9<cr>', desc = 'which_key_ignore' }
