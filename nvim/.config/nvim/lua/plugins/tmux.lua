vim.pack.add { 'https://github.com/christoomey/vim-tmux-navigator' }
vim.g.tmux_navigator_no_mappings = 1
Map { '<C-h>', '<cmd>TmuxNavigateLeft<cr>', mode = { 'n', 'v' } }
Map { '<C-j>', '<cmd>TmuxNavigateDown<cr>', mode = { 'n', 'v' } }
Map { '<C-k>', '<cmd>TmuxNavigateUp<cr>', mode = { 'n', 'v' } }
Map { '<C-l>', '<cmd>TmuxNavigateRight<cr>', mode = { 'n', 'v' } }
Map { '<C-h>', [[<C-\><C-n><cmd>TmuxNavigateLeft<cr>]], mode = 't' }
Map { '<C-j>', [[<C-\><C-n><cmd>TmuxNavigateDown<cr>]], mode = 't' }
Map { '<C-k>', [[<C-\><C-n><cmd>TmuxNavigateUp<cr>]], mode = 't' }
Map { '<C-l>', [[<C-\><C-n><cmd>TmuxNavigateRight<cr>]], mode = 't' }
