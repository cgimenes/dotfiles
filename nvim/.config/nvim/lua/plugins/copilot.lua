return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = 'zbirenbaum/copilot.lua',
    config = true,
  },
}
