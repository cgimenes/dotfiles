return {
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gb', '<cmd>G blame<cr>', desc = '[G]it [B]lame' },
      { '<leader>gc', '<cmd>G mergetool<cr>', desc = 'List [G]it [C]onflicts' },
      { '<leader>gd', '<cmd>Gvdiff<cr>', desc = '[G]it [D]iff' },
      { '<leader>gB', ':GBrowse<cr>', desc = '[G]it [B]rowse', mode = { 'n', 'v' } },
      { '<leader>gg', '<cmd>vert G<cr>', desc = '[G]it Status' },
    },
    dependencies = {
      'tpope/vim-rhubarb',
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewClose',
    },
    keys = {
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File History' },
    },
    config = function()
      local diffview = require 'diffview'

      require('diffview').setup {
        keymaps = {
          file_history_panel = {
            { 'n', 'gq', diffview.close, { desc = 'Close' } },
          },
        },
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '󰐊' },
        topdelete = { text = '󰐊' },
        changedelete = { text = '▎' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = '[G]it hunk [P]review' })
        vim.keymap.set('n', '<leader>gR', gs.reset_hunk, { buffer = bufnr, desc = '[G]it hunk [R]eset' })
        vim.keymap.set('n', '<leader>gl', gs.blame_line, { buffer = bufnr, desc = '[G]it Blame [L]ine' })

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
    -- gw - open the workflow file below the cursor on GitHub
    -- gr - open the workflow run below the cursor on GitHub
    -- gj - open the job of the workflow run below the cursor on GitHub
    -- d - dispatch a new run for the workflow below the cursor on GitHub
    'topaxi/gh-actions.nvim',
    config = true,
    keys = {
      { '<leader>ga', '<cmd>GhActions<cr>', desc = 'Open Github [A]ctions' },
    },
  },
}
