return {
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
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
        keyword = 'bg',
      },
    },
    keys = {
      { '<leader>st', '<cmd>TodoFzfLua<cr>', desc = '[S]earch [T]odo' },
    },
  },
}
