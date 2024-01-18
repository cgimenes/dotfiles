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
      { 'ha', function() require('harpoon'):list():append() end, desc = '[A]dd to Harpoon' },
      { 'hm', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = '[H]arpoon [M]enu' },
      { 'h1', function() require('harpoon'):list():select(1) end, desc = '[H]arpoon [1]' },
      { 'h2', function() require('harpoon'):list():select(2) end, desc = '[H]arpoon [2]' },
      { 'h3', function() require('harpoon'):list():select(3) end, desc = '[H]arpoon [3]' },
      { 'h4', function() require('harpoon'):list():select(4) end, desc = '[H]arpoon [4]' },
      { 'h5', function() require('harpoon'):list():select(5) end, desc = '[H]arpoon [5]' },
      { 'hn', function() require('harpoon'):list():next() end, desc = '[H]arpoon [N]ext' },
      { 'hp', function() require('harpoon'):list():prev() end, desc = '[H]arpoon [P]revious' },
    },
  },
}
