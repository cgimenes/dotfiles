return {
  {
    'tpope/vim-fugitive',
    config = function ()
      vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr><C-w>o', { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiff<cr>', { desc = '[G]it [D]iff' })
      vim.keymap.set('n', '<leader>gb', '<cmd>G blame<cr>', { desc = '[G]it [B]lame' })
    end,
    dependencies = {
      "tpope/vim-rhubarb",
    }
  },
  {
    "sindrets/diffview.nvim",
    cmd = 'DiffviewFileHistory',
    keys = {
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    }
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = 'LazyGit',
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Restore Session" },
    }
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "󰐊" },
        topdelete = { text = "󰐊" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = '[G]it hunk [P]review' })
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
  }
}