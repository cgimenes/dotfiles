return {
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
}
