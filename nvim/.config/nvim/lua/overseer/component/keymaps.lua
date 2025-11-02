---@type overseer.ComponentFileDefinition
return {
  desc = "Component to set task's buffer some keymaps",
  constructor = function(_)
    return {
      --- @param task overseer.Task
      on_start = function(_, task)
        vim.keymap.set('n', 'gf', '<c-w>sgF<c-w>H<c-w>l<c-w>q', { buffer = task:get_bufnr() })

        vim.keymap.set('n', 'q', '<c-w>q', { buffer = task:get_bufnr() })

        vim.keymap.set('n', 'D', function()
          task:dispose(true)
          vim.cmd 'q'
        end, { buffer = task:get_bufnr() })

        vim.keymap.set('n', 'R', function()
          task:restart(true)
        end, { buffer = task:get_bufnr() })

        vim.keymap.set('n', 'W', function()
          if task:get_component 'restart_on_save' then
            task:remove_component 'restart_on_save'
            vim.notify('Auto Restart Disabled', vim.log.levels.INFO, { title = 'Overseer' })
          else
            task:add_component { 'restart_on_save', delay = 1 }
            vim.notify('Auto Restart Enabled', vim.log.levels.INFO, { title = 'Overseer' })
          end
        end, { buffer = task:get_bufnr() })
      end,
    }
  end,
}
