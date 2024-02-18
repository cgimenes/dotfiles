return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("harpoon"):setup()

      local colors = require("kanagawa.colors").setup()
      local theme_colors = colors.theme
      vim.cmd('highlight! HarpoonActive guibg=' .. theme_colors.ui.bg .. ' guifg=' .. theme_colors.syn.identifier)
      vim.cmd('highlight! HarpoonNumberActive guibg=' .. theme_colors.ui.bg .. ' guifg=' .. theme_colors.syn.number)
      vim.cmd('highlight! HarpoonInactive guibg=' .. theme_colors.ui.bg_p1 .. ' guifg=' .. theme_colors.ui.fg)
      vim.cmd('highlight! HarpoonNumberInactive guibg=' .. theme_colors.ui.bg_p1 .. ' guifg=' .. theme_colors.syn.number)
    end,
    keys = {
      { '<leader>ha', function() require('harpoon'):list():append() end,                                 desc = '[A]dd to Harpoon' },
      { '<leader>hm', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = '[H]arpoon [M]enu' },
      { '<leader>h1', function() require('harpoon'):list():select(1) end,                                desc = '[H]arpoon [1]' },
      { '<leader>h2', function() require('harpoon'):list():select(2) end,                                desc = '[H]arpoon [2]' },
      { '<leader>h3', function() require('harpoon'):list():select(3) end,                                desc = '[H]arpoon [3]' },
      { '<leader>h4', function() require('harpoon'):list():select(4) end,                                desc = '[H]arpoon [4]' },
      { '<leader>h5', function() require('harpoon'):list():select(5) end,                                desc = '[H]arpoon [5]' },
      { '<leader>hn', function() require('harpoon'):list():next() end,                                   desc = '[H]arpoon [N]ext' },
      { '<leader>hp', function() require('harpoon'):list():prev() end,                                   desc = '[H]arpoon [P]revious' },
    },
  },
}
