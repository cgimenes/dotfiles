-- Highlight todo, notes, etc in comments
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/folke/todo-comments.nvim',
}
require('todo-comments').setup {
  signs = false,
  search = {
    pattern = [[\b(KEYWORDS)\b]],
  },
  highlight = {
    pattern = [[.*<(KEYWORDS)\s*:?\s*]],
    keyword = 'bg',
  },
}
Map {
  '<leader>st',
  function()
    Snacks.picker.todo_comments()
  end,
  desc = 'Todo',
}
