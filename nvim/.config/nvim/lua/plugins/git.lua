return {
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gc', '<cmd>G mergetool<cr>', desc = 'List Git Conflicts' },
    },
  },
  {
    'sindrets/diffview.nvim',
    config = true,
    cmd = { 'DiffviewClose' },
    keys = {
      { '<leader>gh', ':DiffviewFileHistory %<cr>', desc = 'File History', mode = { 'n', 'v' } },
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git Diffview' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      update_debounce = 500,
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        vim.keymap.set('n', '<leader>gb', gitsigns.blame, { buffer = bufnr, desc = 'Git Blame' })
        vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk_inline, { buffer = bufnr, desc = 'Preview hunk' })
        vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { buffer = bufnr, desc = 'Stage buffer' })
        vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
        vim.keymap.set('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { buffer = bufnr, desc = 'Reset hunk' })

        vim.keymap.set({ 'o', 'x' }, 'ih', '<Cmd>Gitsigns select_hunk<CR>')

        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gitsigns.nav_hunk 'next'
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gitsigns.nav_hunk 'prev'
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },
  {
    -- gp - open the workflow file below the cursor on GitHub
    -- gr - open the workflow run below the cursor on GitHub
    -- gj - open the job of the workflow run below the cursor on GitHub
    -- d - dispatch a new run for the workflow below the cursor on GitHub
    'topaxi/pipeline.nvim',
    config = true,
    keys = {
      { '<leader>ga', '<cmd>Pipeline<cr>', desc = 'Open Github Actions' },
    },
  },
  {
    'pwntester/octo.nvim',
    cmd = { 'Octo' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/snacks.nvim',
      'nvim-mini/mini.icons',
    },
    opts = {
      enable_builtin = true,
      picker = 'snacks',
      use_local_fs = true,
      file_panel = { size = 5 },
    },
    keys = {
      { '<leader>gp', '<cmd>Octo pr list<cr>', desc = 'List GitHub PRs' },
    },
  },
}
