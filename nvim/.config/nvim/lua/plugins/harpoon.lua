return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      { '<leader>a', function() require('harpoon'):list():append() end, desc = '[A]dd to Harpoon' },
      { '<C-g>', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = '[H]arpoon Menu' },
      { '<leader>h1', function() require('harpoon'):list():select(1) end, desc = '[1] Harpoon' },
      { '<leader>h2', function() require('harpoon'):list():select(2) end, desc = '[2] Harpoon' },
      { '<leader>h3', function() require('harpoon'):list():select(3) end, desc = '[3] Harpoon' },
      { '<leader>h4', function() require('harpoon'):list():select(4) end, desc = '[4] Harpoon' },
      { '<leader>h5', function() require('harpoon'):list():select(5) end, desc = '[5] Harpoon' },
      { '<leader>hn', function() require('harpoon'):list():next() end, desc = '[H]arpoon [N]ext' },
      { '<leader>hp', function() require('harpoon'):list():prev() end, desc = '[H]arpoon [P]revious' },
    },
  },
}
