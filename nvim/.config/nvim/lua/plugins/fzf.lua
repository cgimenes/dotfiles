return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  opts = {
    winopts = {
      preview = {
        wrap = 'wrap',
        hidden = true,
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
        ['<M-p>'] = 'toggle-preview',
      },
      fzf = {
        ['ctrl-f'] = 'half-page-down',
        ['ctrl-b'] = 'half-page-up',
        ['ctrl-a'] = 'beginning-of-line',
        ['ctrl-e'] = 'end-of-line',
        ['ctrl-d'] = 'preview-page-down',
        ['ctrl-u'] = 'preview-page-up',
        ['ctrl-q'] = 'select-all+accept',
        ['ctrl-y'] = 'accept',
      },
    },
  },
  -- keys = {
  --   -- Buffers
  --   { '<leader>bl', '<cmd>FzfLua buffers<cr>', desc = '[L]ist existing buffers' },
  --
  --   -- Files
  --   { '<leader>sr', '<cmd>FzfLua oldfiles<cr>', desc = '[S]earch [R]ecently opened files' },
  --   {
  --     '<leader>sf',
  --     function()
  --       require('fzf-lua').files()
  --     end,
  --     desc = '[S]earch [F]iles',
  --   },
  --
  --   -- Search
  --   { '<leader>sl', '<cmd>FzfLua resume<cr>', desc = '[S]earch Resume' },
  --   { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = '[S]earch [H]elp' },
  --   { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = '[S]earch [K]eymaps' },
  --   { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = '[S]earch current [W]ord' },
  --   { '<leader>sm', '<cmd>FzfLua manpages<cr>', desc = '[S]earch [M]anpages' },
  --   { '<leader>sv', '<cmd>FzfLua grep_visual<cr>', desc = '[S]earch current selection', mode = 'v' },
  --   {
  --     '<leader>sg',
  --     function()
  --       require('fzf-lua').live_grep()
  --     end,
  --     desc = '[S]earch by [G]rep',
  --   },
  --
  --   -- Options
  --   { '<leader>oc', '<cmd>FzfLua colorschemes<cr>', desc = '[S]earch Colorschemes' },
  --   { '<leader>of', '<cmd>FzfLua filetypes<cr>', desc = 'Change [F]iletype' },
  --
  --   -- LSP
  --   { 'gd', '<cmd>FzfLua lsp_definitions<cr>', desc = '[G]oto [D]efinition' },
  --   { 'grr', '<cmd>FzfLua lsp_references<cr>', desc = '[G]oto [R]eferences' },
  --   { 'gri', '<cmd>FzfLua lsp_implementations<cr>', desc = '[G]oto [I]mplementation' },
  --   { 'gra', '<cmd>FzfLua lsp_code_actions<cr>', desc = '[C]ode [A]ctions' },
  --   { 'gO', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Document [S]ymbols' },
  --   { '<leader>lS', '<cmd>FzfLua lsp_live_workspace_symbols<cr>', desc = 'Workspace [S]ymbols' },
  --   { '<leader>ld', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Document [D]iagnostics' },
  --   -- Jump to the type of the word under your cursor.
  --   --  Useful when you're not sure what type a variable is and you want to see
  --   --  the definition of its *type*, not where it was *defined*.
  --   { '<leader>lT', '<cmd>FzfLua lsp_type_definitions<cr>', desc = '[T]ype Definition' },
  --
  --   -- Paste
  --   { '<leader>pr', '<cmd>FzfLua registers<cr>', desc = '[P]aste [R]egister', mode = { 'n', 'v' } },
  --
  --   -- Jumps
  --   { '<leader>J', '<cmd>FzfLua jumps<cr>', desc = '[J]umps' },
  -- },
}
