return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = function()
      vim.keymap.set('n', '<leader>;', '<cmd>Dashboard<cr>', { desc = 'Dashboard' }) -- I don't like this here

      local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
      logo = string.rep('\n', 3) .. logo .. '\n\n'

      local opts = {
        theme = 'doom',
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, '\n'),
          center = {
            { action = 'Oil', desc= ' Oil', key = 'o' },
            { action = 'ene | startinsert', desc = ' New file', key = 'n' },
            { action = 'Lazy', desc = ' Lazy', key = 'l' },
            { action = 'qa', desc = ' Quit', key = 'q' },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 35 - #button.desc)
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'DashboardLoaded',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      return opts
    end,
  },
}
