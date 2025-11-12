---@type overseer.ComponentFileDefinition
return {
  desc = "Component to set task's buffer some keymaps",
  constructor = function(_)
    return {
      --- @param task overseer.Task
      on_start = function(_, task)
        vim.keymap.set('n', 'q', '<c-w>q', { buffer = task:get_bufnr() })

        vim.keymap.set('n', ',d', function()
          task:dispose(true)
          vim.cmd 'q'
        end, { buffer = task:get_bufnr(), desc = 'Dispose' })

        vim.keymap.set('n', ',r', function()
          task:restart(true)
        end, { buffer = task:get_bufnr(), desc = 'Restart' })

        vim.keymap.set('n', ',w', function()
          if task:get_component 'restart_on_save' then
            task:remove_component 'restart_on_save'
            vim.notify('Auto Restart Disabled', vim.log.levels.INFO, { title = 'Overseer' })
          else
            task:add_component { 'restart_on_save', delay = 1 }
            vim.notify('Auto Restart Enabled', vim.log.levels.INFO, { title = 'Overseer' })
          end
        end, { buffer = task:get_bufnr(), desc = 'Toggle watch' })

        vim.keymap.set('n', ',c', function()
          if task:get_component 'on_complete_dispose' then
            task:remove_component 'on_complete_dispose'
            vim.notify('Dispose on Complete Disabled', vim.log.levels.INFO, { title = 'Overseer' })
          else
            task:add_component { 'on_complete_dispose', statuses = { 'SUCCESS' }, timeout = 5 }
            vim.notify('Dispose on Complete Enabled', vim.log.levels.INFO, { title = 'Overseer' })
          end
        end, { buffer = task:get_bufnr(), desc = 'Toggle dispose on complete' })
      end,
    }
  end,
}
