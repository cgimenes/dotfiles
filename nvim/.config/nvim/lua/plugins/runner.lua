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
          ['<C-h>'] = false,
          ['<C-j>'] = false,
          ['<C-k>'] = false,
          ['<C-l>'] = false,
        },
      },
    },
    keys = {
      { '<leader>rr', '<cmd>OverseerRun<cr>', desc = 'Overseer Run' },
      {
        '<leader>rR',
        function()
          local overseer = require 'overseer'
          overseer.run_template(nil, function(task)
            if task then
              task:add_component { 'restart_on_save', delay = 1 }
              local main_win = vim.api.nvim_get_current_win()
              overseer.run_action(task, 'open vsplit')
              vim.api.nvim_set_current_win(main_win)
            else
              vim.notify('WatchRun not supported for filetype ' .. vim.bo.filetype, vim.log.levels.ERROR)
            end
          end)
        end,
        desc = 'Overseer Run and Watch',
      },
      { '<leader>rt', '<cmd>OverseerToggle<cr>', desc = 'Overseer Toggle' },
      { '<leader>rq', '<cmd>OverseerQuickAction<cr>', desc = 'Overseer QuickAction' },
    },
  },
}
