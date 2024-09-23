return {
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = false,
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*:?\s*]],
        keyword = "bg"
      },
    },
    keys = {
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odo' },
    },
  },
}
