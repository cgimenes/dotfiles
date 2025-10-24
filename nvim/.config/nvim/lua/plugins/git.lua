-- Fugitive
vim.pack.add { 'https://github.com/tpope/vim-fugitive' }
Map { '<leader>gc', '<cmd>G mergetool<cr>', desc = 'List Git Conflicts' }
Map { '<leader>gd', '<cmd>vertical G diff<cr>', desc = 'Git Diff' }

-- Diffview
vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }
require('diffview').setup {}
Map { '<leader>gh', ':DiffviewFileHistory %<cr>', desc = 'File History', mode = { 'n', 'v' } }
Map { '<leader>gD', '<cmd>DiffviewOpen<cr>', desc = 'Git Diffview' }

-- Gitsigns
vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
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
}

-- gp - open the workflow file below the cursor on GitHub
-- gr - open the workflow run below the cursor on GitHub
-- gj - open the job of the workflow run below the cursor on GitHub
-- d - dispatch a new run for the workflow below the cursor on GitHub
vim.pack.add { 'https://github.com/topaxi/pipeline.nvim' }
require('pipeline').setup {}
Map { '<leader>ga', '<cmd>Pipeline<cr>', desc = 'Open Github Actions' }

-- Octo.nvim (GitHub PRs and Issues)
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/pwntester/octo.nvim',
}
require('octo').setup {
  enable_builtin = true,
  picker = 'snacks',
  use_local_fs = true,
  file_panel = { size = 5 },
}
Map { '<leader>gp', '<cmd>Octo pr list<cr>', desc = 'List GitHub PRs' }
