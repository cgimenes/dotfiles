vim.pack.add { 'https://github.com/ibhagwan/fzf-lua' }
require('fzf-lua').setup {
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
}
-- -- Buffers
-- Map { '<leader>bl', '<cmd>FzfLua buffers<cr>', desc = '[L]ist existing buffers' }
--
-- -- Files
-- Map { '<leader>sr', '<cmd>FzfLua oldfiles<cr>', desc = '[S]earch [R]ecently opened files' }
-- Map {
--   '<leader>sf',
--   function()
--     require('fzf-lua').files()
--   end,
--   desc = '[S]earch [F]iles',
-- }
--
-- -- Search
-- Map { '<leader>sl', '<cmd>FzfLua resume<cr>', desc = '[S]earch Resume' }
-- Map { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = '[S]earch [H]elp' }
-- Map { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = '[S]earch [K]eymaps' }
-- Map { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = '[S]earch current [W]ord' }
-- Map { '<leader>sm', '<cmd>FzfLua manpages<cr>', desc = '[S]earch [M]anpages' }
-- Map { '<leader>sv', '<cmd>FzfLua grep_visual<cr>', desc = '[S]earch current selection', mode = 'v' }
-- Map {
--   '<leader>sg',
--   function()
--     require('fzf-lua').live_grep()
--   end,
--   desc = '[S]earch by [G]rep',
-- }
--
-- -- Options
-- Map { '<leader>oc', '<cmd>FzfLua colorschemes<cr>', desc = '[S]earch Colorschemes' }
-- Map { '<leader>of', '<cmd>FzfLua filetypes<cr>', desc = 'Change [F]iletype' }
--
-- -- LSP
-- Map { 'gd', '<cmd>FzfLua lsp_definitions<cr>', desc = '[G]oto [D]efinition' }
-- Map { 'grr', '<cmd>FzfLua lsp_references<cr>', desc = '[G]oto [R]eferences' }
-- Map { 'gri', '<cmd>FzfLua lsp_implementations<cr>', desc = '[G]oto [I]mplementation' }
-- Map { 'gra', '<cmd>FzfLua lsp_code_actions<cr>', desc = '[C]ode [A]ctions' }
-- Map { 'gO', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Document [S]ymbols' }
-- Map { '<leader>lS', '<cmd>FzfLua lsp_live_workspace_symbols<cr>', desc = 'Workspace [S]ymbols' }
-- Map { '<leader>ld', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Document [D]iagnostics' }
-- -- Jump to the type of the word under your cursor.
-- --  Useful when you're not sure what type a variable is and you want to see
-- --  the definition of its *type*, not where it was *defined*.
-- Map { '<leader>lT', '<cmd>FzfLua lsp_type_definitions<cr>', desc = '[T]ype Definition' }
--
-- -- Paste
-- Map { '<leader>pr', '<cmd>FzfLua registers<cr>', desc = '[P]aste [R]egister', mode = { 'n', 'v' } }
--
-- -- Jumps
-- Map { '<leader>J', '<cmd>FzfLua jumps<cr>', desc = '[J]umps' }
