return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  opts = {
    'default-title',
    winopts = {
      preview = {
        wrap = 'wrap',
      },
    },
    files = {
      git_icons = false,
    },
    grep = {
      rg_opts = '--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
      RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
      rg_glob = true, -- always parse glob patterns
    },
    keymap = {
      builtin = {
        ['<C-d>'] = 'preview-page-down',
        ['<C-u>'] = 'preview-page-up',
      },
      fzf = {
        ['ctrl-f'] = 'half-page-down',
        ['ctrl-b'] = 'half-page-up',
        ['ctrl-a'] = 'beginning-of-line',
        ['ctrl-e'] = 'end-of-line',
        ['ctrl-d'] = 'preview-page-down',
        ['ctrl-u'] = 'preview-page-up',
        ['ctrl-q'] = 'select-all+accept',
      },
    },
  },
  keys = {
    { '<leader>of', '<cmd>FzfLua filetypes<cr>', desc = 'Change [F]iletype' },
    { '<leader>oC', '<cmd>FzfLua awesome_colorscheme<cr>', desc = 'Awesome Colorscheme' },
    { '<leader>li', '<cmd>FzfLua lsp_incoming_calls<cr>', desc = 'Incoming calls' },
    { 'gra', '<cmd>FzfLua lsp_code_actions<cr>', desc = 'Code Actions' },
  },
}
