vim.api.nvim_create_user_command('OverseerLastTaskAction', function(params)
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
    overseer.run_action(most_recent, params.args)
  end
end, { desc = 'Run action on last Overseer task', nargs = '*' })

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
end, { desc = 'Run your makeprg as an Overseer task', nargs = '*', bang = true })

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

vim.api.nvim_create_user_command('OS', function(params)
  if params.args and params.args ~= '' then
    local task = require('overseer.task').new { cmd = params.args }
    task:add_component { 'keymaps' }
    if not params.bang then
      task:start()
    end
  else
    vim.ui.input({ prompt = 'command', completion = 'shellcmdline' }, function(cmd)
      if cmd then
        local task = require('overseer.task').new { cmd = cmd }
        task:add_component { 'keymaps' }
        if params.bang then
          task:add_component { 'restart_on_save', delay = 1 }
        end
        task:start()
      end
    end)
  end
end, { nargs = '*', bang = true, complete = 'shellcmdline' })

vim.pack.add {
  { src = 'https://github.com/stevearc/overseer.nvim' },
}
require('overseer').setup {
  dap = false,
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
}
Map {
  '<leader>rr',
  function()
    require('overseer').run_task({ autostart = false }, function(task)
      if task then
        task:add_component { 'keymaps' }
        if task:get_component 'on_complete_dispose' then
          task:remove_component 'on_complete_dispose'
        end
        task:add_component { 'on_complete_dispose', statuses = { 'SUCCESS' }, timeout = 5 }

        task:start()
        task:open_output 'vertical'
      end
    end)
  end,
  desc = 'Overseer Run',
}
Map { '<leader>rl', '<cmd>OverseerToggle<cr>', desc = 'Toggle Task List' }
Map { '<leader>ra', '<cmd>OverseerTaskAction<cr>', desc = 'Task Action' }
Map { '<leader>rv', '<cmd>OverseerLastTaskAction open vsplit<cr>', desc = "Open last task's output in a vsplit" }
Map { '<leader>rt', '<cmd>OverseerLastTaskAction open tab<cr>', desc = "Open last task's output in a tab" }
Map { '<leader>rD', '<cmd>OverseerLastTaskAction dispose<cr>', desc = 'Dispose last task' }
Map { '<leader>rR', '<cmd>OverseerLastTaskAction restart<cr>', desc = 'Restart last task' }
