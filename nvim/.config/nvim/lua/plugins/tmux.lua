return {
  {
    'christoomey/vim-tmux-navigator',
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    },
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
      { '<leader>rc', '<cmd>VimuxPromptCommand<cr>', desc = '[R]un [C]ommand on Tmux' },
    },
  },
}
