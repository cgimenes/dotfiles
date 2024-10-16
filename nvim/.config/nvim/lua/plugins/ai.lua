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
  {
    'robitx/gp.nvim',
    opts = {
      providers = {
        openai = {
          disable = true,
        },
        copilot = {
          endpoint = 'https://api.githubcopilot.com/chat/completions',
          secret = {
            'bash',
            '-c',
            "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
          },
        },
      },
    },
    keys = {
      { '<leader>ac', '<cmd>GpChatToggle<cr>', desc = '[A]I Toggle [C]hat' },
    },
  },
}
