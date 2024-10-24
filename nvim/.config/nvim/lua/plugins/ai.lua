return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = "InsertEnter",
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
      panel = { enabled = true },
    },
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
      { '<leader>ap', '<cmd>GpPopup<cr>', desc = '[A]I [P]opup' },
    },
  },
}
