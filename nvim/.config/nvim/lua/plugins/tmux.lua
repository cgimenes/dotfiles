return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
    },
    keys = {
      { '<C-h>', '<cmd>TmuxNavigateLeft<cr>', mode = { 'n', 'v' } },
      { '<C-j>', '<cmd>TmuxNavigateDown<cr>', mode = { 'n', 'v' } },
      { '<C-k>', '<cmd>TmuxNavigateUp<cr>', mode = { 'n', 'v' } },
      { '<C-l>', '<cmd>TmuxNavigateRight<cr>', mode = { 'n', 'v' } },
      { '<C-h>', [[<C-\><C-n><cmd>TmuxNavigateLeft<cr>]], mode = 't' },
      { '<C-j>', [[<C-\><C-n><cmd>TmuxNavigateDown<cr>]], mode = 't' },
      { '<C-k>', [[<C-\><C-n><cmd>TmuxNavigateUp<cr>]], mode = 't' },
      { '<C-l>', [[<C-\><C-n><cmd>TmuxNavigateRight<cr>]], mode = 't' },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  {
    'cgimenes/tmux-files.nvim',
    keys = {
      {
        '<leader>sx',
        function()
          require('tmux-files').select()
        end,
        desc = 'Edit file from TMUX panes',
      },
    },
  },
  {
    'preservim/vimux',
    keys = {
      { '<leader>rc', '<cmd>VimuxPromptCommand<cr>', desc = 'Run Command on Tmux' },
      { '<leader>rl', '<cmd>VimuxRunLastCommand<cr>', desc = 'Run Last Command on Tmux' },
    },
  },
}
