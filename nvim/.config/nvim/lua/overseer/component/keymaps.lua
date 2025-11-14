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

        vim.keymap.set('n', '<CR>', function()
          local line = vim.api.nvim_get_current_line()

          local cfile = vim.fn.expand '<cfile>'
          local start_idx = line:find(cfile, 1, true)
          if not start_idx then
            print 'Path not found on current line'
            return
          end
          local trimmed_line = line:sub(start_idx)

          -- Pipe this all into quickfix to take advantage of the errorformatting that it does
          local original_qf_state = vim.fn.getqflist { all = 0 }
          local original_efm = vim.go.errorformat

          local temp_efm = table.concat({
            '%f:%l:%c:%m',
            '%f:%l:%c',
            '%f:%l',
          }, ',')
          vim.go.errorformat = temp_efm .. ',' .. original_efm
          vim.fn.setqflist({}, 'r', { lines = { trimmed_line } })
          local qf_items = vim.fn.getqflist()

          vim.go.errorformat = original_efm
          vim.fn.setqflist({}, 'r', {
            items = original_qf_state.items,
            title = original_qf_state.title,
          })

          local lnum = qf_items[1].lnum
          local col = qf_items[1].col

          local full_path = vim.fs.normalize(vim.fs.joinpath(vim.fn.getcwd(), cfile))
          if not vim.uv.fs_stat(full_path) and vim.uv.fs_stat(cfile) then
            full_path = vim.fs.normalize(cfile)
          end
          if not vim.uv.fs_stat(full_path) then
            return nil
          end

          local open_to_cmd = 'edit +' .. lnum .. ' ' .. vim.fn.fnameescape(full_path)
          if type(col) == 'number' and col > 0 then
            open_to_cmd = open_to_cmd .. ' | normal! ' .. col .. '|'
          end

          local window = Snacks.picker.util.pick_win()
          vim.fn.win_execute(window, open_to_cmd)
          vim.api.nvim_set_current_win(window)
        end, {
          buffer = task:get_bufnr(),
          desc = 'Open file on line number (pick window)',
          noremap = true,
          silent = true,
        })
      end,
    }
  end,
}
