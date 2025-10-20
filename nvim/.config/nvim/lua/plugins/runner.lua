local function action_on_last_task(name)
  local overseer = require 'overseer'
  local task_list = require 'overseer.task_list'
  local tasks = overseer.list_tasks {
    status = {
      overseer.STATUS.PENDING,
      overseer.STATUS.RUNNING,
      overseer.STATUS.SUCCESS,
      overseer.STATUS.FAILURE,
      overseer.STATUS.CANCELED,
    },
    sort = task_list.sort_finished_recently,
  }
  if vim.tbl_isempty(tasks) then
    vim.notify('No tasks found', vim.log.levels.WARN)
  else
    local most_recent = tasks[1]
    overseer.run_action(most_recent, name)
  end
end

vim.api.nvim_create_user_command('Make', function(params)
  -- Insert args at the '$*' in the makeprg
  local cmd, num_subs = vim.o.makeprg:gsub('%$%*', params.args)
  if num_subs == 0 then
    cmd = cmd .. ' ' .. params.args
  end
  local task = require('overseer').new_task {
    cmd = vim.fn.expandcmd(cmd),
    components = {
      { 'on_output_quickfix', open = not params.bang, open_height = 8 },
      'default',
    },
  }
  task:start()
end, {
  desc = 'Run your makeprg as an Overseer task',
  nargs = '*',
  bang = true,
})

vim.api.nvim_create_user_command('Grep', function(params)
  -- Insert args at the '$*' in the grepprg
  local cmd, num_subs = vim.o.grepprg:gsub('%$%*', params.args)
  if num_subs == 0 then
    cmd = cmd .. ' ' .. params.args
  end
  local task = require('overseer').new_task {
    cmd = vim.fn.expandcmd(cmd),
    components = {
      {
        'on_output_quickfix',
        errorformat = vim.o.grepformat,
        open = not params.bang,
        open_height = 8,
        items_only = true,
      },
      -- We don't care to keep this around as long as most tasks
      { 'on_complete_dispose', timeout = 30 },
      'default',
    },
  }
  task:start()
end, { nargs = '*', bang = true, complete = 'file' })

vim.cmd.cnoreabbrev("OS OverseerShell")

return {
  {
    'stevearc/overseer.nvim',
    branch = 'stevearc-rewrite',
    ---@type overseer.SetupOpts
    opts = {
      dap = false,
      templates = {
        'builtin',
        'user.run_script',
        'user.rails_dev',
        'user.uv_run',
      },
      task_list = {
        keymaps = {
          ['K'] = { 'keymap.scroll_output_up', desc = 'Scroll Output Up' },
          ['J'] = { 'keymap.scroll_output_down', desc = 'Scroll Output Down' },
          ['<C-h>'] = false,
          ['<C-j>'] = false,
          ['<C-k>'] = false,
          ['<C-l>'] = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { '<leader>rr', '<cmd>OverseerRun<cr>', desc = 'Overseer Run' },
      { '<leader>rt', '<cmd>OverseerToggle<cr>', desc = 'Overseer Toggle' },
      { '<leader>ra', '<cmd>OverseerTaskAction<cr>', desc = 'Overseer Task Action' },
      { '<leader>rv', function() action_on_last_task 'open vsplit' end, desc = 'Overseer Open vsplit' },
      { '<leader>rd', function() action_on_last_task 'dispose' end, desc = 'Overseer Dispose' },
      {
        '<leader>rR',
        function()
          local overseer = require 'overseer'
          overseer.run_task({ autostart = false }, function(task)
            if task then
              task:add_component { 'restart_on_save', delay = 1 }
              task:start()
              task:open_output 'vertical'
            else
              vim.notify('Run and Watch not supported for filetype ' .. vim.bo.filetype, vim.log.levels.ERROR)
            end
          end)
        end,
        desc = 'Overseer Run and Watch',
      },
    },
  },
}
