return {
  {
    'stevearc/overseer.nvim',
    opts = {
      dap = false,
      templates = {
        'builtin',
        'user.run_script',
        'user.rails_dev',
        'user.uv_run',
      },
      task_list = {
        bindings = {
          ['K'] = 'ScrollOutputUp',
          ['J'] = 'ScrollOutputDown',
          ['<C-k>'] = false,
          ['<C-j>'] = false,
        },
      },
    },
    keys = {
      { '<leader>rr', '<cmd>OverseerRun<cr>', desc = 'Overseer [R]un' },
      { '<leader>rt', '<cmd>OverseerToggle<cr>', desc = 'Overseer [T]oggle' },
      { '<leader>rq', '<cmd>OverseerQuickAction<cr>', desc = 'Overseer [Q]uickAction' },
      {
        '<leader>rw',
        function()
          local overseer = require 'overseer'
          overseer.run_template({ name = 'run script' }, function(task)
            if task then
              task:add_component { 'restart_on_save', paths = { vim.fn.expand '%:p' } }
              local main_win = vim.api.nvim_get_current_win()
              overseer.run_action(task, 'open vsplit')
              vim.api.nvim_set_current_win(main_win)
            else
              vim.notify('WatchRun not supported for filetype ' .. vim.bo.filetype, vim.log.levels.ERROR)
            end
          end)
        end,
        desc = 'Overseer [W]atch',
      },
    },
  },
}
