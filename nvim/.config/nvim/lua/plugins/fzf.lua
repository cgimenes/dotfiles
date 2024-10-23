return {
  'ibhagwan/fzf-lua',
  opts = {
    grep = {
      rg_opts = '--hidden --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
    },
  },
  keys = {
    -- Buffers
    { '<leader>bl', '<cmd>FzfLua buffers<cr>', desc = '[L]ist existing buffers' },

    -- Files
    { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Search [R]ecently opened files' },
    {
      '<leader>.',
      function()
        if vim.bo.filetype == 'oil' then
          local basedir = require('oil').get_current_dir()
          require('fzf-lua').files { cwd = basedir }
        else
          require('fzf-lua').files()
        end
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>fF',
      function()
        require('fzf-lua').files()
      end,
      desc = '[S]earch [F]iles',
    },

    -- Search
    { '<leader>sl', '<cmd>FzfLua resume<cr>', desc = '[S]earch Resume' },
    { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = '[S]earch [H]elp' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = '[S]earch [K]eymaps' },
    { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = '[S]earch current [W]ord' },
    { '<leader>sm', '<cmd>FzfLua manpages<cr>', desc = '[S]earch [M]anpages' },
    { '<leader>sv', '<cmd>FzfLua grep_visual<cr>', desc = '[S]earch current selection', mode = 'v' },
    {
      '<leader>sg',
      function()
        if vim.bo.filetype == 'oil' then
          local basedir = require('oil').get_current_dir()
          require('fzf-lua').live_grep { cwd = basedir }
        else
          require('fzf-lua').live_grep()
        end
      end,
      desc = '[S]earch by [G]rep',
    },

    -- Options
    { '<leader>oc', '<cmd>FzfLua colorschemes<cr>', desc = '[S]earch Colorschemes' },
    { '<leader>of', '<cmd>FzfLua filetypes<cr>', desc = 'Change [F]iletype' },

    -- LSP
    { 'gr', '<cmd>FzfLua lsp_references<cr>', desc = '[G]oto [R]eferences' },
    { 'gi', '<cmd>FzfLua lsp_implementations<cr>', desc = '[G]oto [I]mplementation' },
    { '<leader>lT', '<cmd>FzfLua lsp_type_definitions<cr>', desc = '[T]ype Definition' },
    { '<leader>ls', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Document [S]ymbols' },
    { '<leader>lS', '<cmd>FzfLua lsp_dynamic_workspace_symbols<cr>', desc = 'Workspace [S]ymbols' },
    { '<leader>ld', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Document [D]iagnostics' },

    -- Paste
    { '<leader>pr', '<cmd>FzfLua registers<cr>', desc = '[P]aste [R]egister', mode = { 'n', 'v' } },
  },
}
