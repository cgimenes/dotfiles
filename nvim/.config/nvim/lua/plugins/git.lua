return {
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
    keys = {
      { '<leader>gb', '<cmd>G blame<cr>', desc = 'Git Blame' },
      { '<leader>gc', '<cmd>G mergetool<cr>', desc = 'List Git Conflicts' },
      { '<leader>gd', '<cmd>Gvdiff<cr>', desc = 'Git Diff' },
      { '<leader>gB', ':GBrowse<cr>', desc = 'Git Browse', mode = { 'n', 'v' } },
    },
  },
  {
    'sindrets/diffview.nvim',
    config = true,
    cmd = {
      'DiffviewClose',
    },
    keys = {
      { '<leader>gh', ':DiffviewFileHistory %<cr>', desc = 'File History', mode = { 'n', 'v' } },
      { '<leader>gD', '<cmd>DiffviewOpen<cr>', desc = 'Git Diffview' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Git hunk Preview' })
        vim.keymap.set('n', '<leader>gR', gs.reset_hunk, { buffer = bufnr, desc = 'Git hunk Reset' })
        vim.keymap.set('n', '<leader>gl', gs.blame_line, { buffer = bufnr, desc = 'Git Blame Line' })

        -- don't override the built-in and fugitive keymaps
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },
  {
    -- ]x next-hunk
    -- [x prev-hunk
    -- ct select-themselves
    -- co select-ourselves
    -- cn select-none
    -- cb select-both
    -- cB select-both-rev
    'rhysd/conflict-marker.vim',
    config = function()
      vim.g.conflict_marker_highlight_group = ''
      vim.api.nvim_set_hl(0, 'ConflictMarkerBegin', { bg = '#2f7366' })
      vim.api.nvim_set_hl(0, 'ConflictMarkerOurs', { bg = '#2e5049' })
      vim.api.nvim_set_hl(0, 'ConflictMarkerTheirs', { bg = '#344f69' })
      vim.api.nvim_set_hl(0, 'ConflictMarkerEnd', { bg = '#2f628e' })
      vim.api.nvim_set_hl(0, 'ConflictMarkerCommonAncestorsHunk', { bg = '#754a81' })
    end,
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
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim', -- optional - Diff integration
      'folke/snacks.nvim',
    },
    opts = {
      kind = 'auto',
    },
    keys = {
      { '<leader>gG', '<cmd>Neogit<cr>', desc = 'Neogit' },
    },
  },
}
