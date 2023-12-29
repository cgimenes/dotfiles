vim.opt.relativenumber = true
vim.opt.endofline = false
vim.opt.endoffile = false
vim.opt.fixendofline = false

lvim.keys.normal_mode["[b"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["]b"] = "<cmd>BufferLineCycleNext<cr>"

lvim.plugins = {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = {"fugitive"},
    dependencies = {
      "tpope/vim-rhubarb",
    },
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
        '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,        -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,              -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "ThePrimeagen/harpoon",
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      module = "persistence",
      config = function()
        require("persistence").setup {
          dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
          options = { "buffers", "curdir", "tabpages", "winsize" },
        }
    end,
  },
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "olimorris/neotest-phpunit",
  --   },
  --   config = function()
  --     require('neotest').setup({
  --       status = { virtual_text = true },
  --       output = { open_on_run = true },
  --       adapters = {
  --         require("neotest-phpunit"),
  --       },
  --     })
  --   end,
  --   keys = {
  --     { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
  --     { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
  --     { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
  --     { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
  --     { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
  --     { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
  --     { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
  --     { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
  --     { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
  --     { "<leader>tc", function() require("neotest").output_panel.clear() end, desc = "Clear Output Panel" },
  --   },
  -- }
}

local telescopeConfig = require("telescope.config")
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/vendor/*")
lvim.builtin.telescope.defaults.vimgrep_arguments = vimgrep_arguments

lvim.builtin.nvimtree.setup.view.width = 80

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

lvim.keys.normal_mode["<leader>a"] = mark.add_file
lvim.keys.normal_mode["<C-h>"] = ui.toggle_quick_menu
lvim.keys.normal_mode["<leader>1"] = function() ui.nav_file(1) end
lvim.keys.normal_mode["<leader>2"] = function() ui.nav_file(2) end
lvim.keys.normal_mode["<leader>3"] = function() ui.nav_file(3) end
lvim.keys.normal_mode["<leader>4"] = function() ui.nav_file(4) end
lvim.keys.normal_mode["<leader>5"] = function() ui.nav_file(5) end

lvim.builtin.which_key.mappings["S"]= {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}