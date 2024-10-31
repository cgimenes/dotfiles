return {
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gb', '<cmd>G blame<cr>', desc = '[G]it [B]lame' },
      { '<leader>gc', '<cmd>G mergetool<cr>', desc = 'List [G]it [C]onflicts' },
      { '<leader>gd', '<cmd>Gvdiff<cr>', desc = '[G]it [D]iff' },
      { '<leader>gB', ':GBrowse<cr>', desc = '[G]it [B]rowse', mode = { 'n', 'v' } },
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
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- optional for floating window border decoration
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
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
        vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { buffer = bufnr, desc = '[G]it hunk [R]eset' })
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
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'ibhagwan/fzf-lua',
      'sindrets/diffview.nvim', -- optional - Diff integration
    },
    config = true,
    keys = {
      { '<leader>gn', '<cmd>Neogit<cr>', desc = '[N]eo[G]it' },
    },
  },
}
