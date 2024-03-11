return {

  {
    'stevearc/profile.nvim',
    config = function()
      local function toggle_profile()
        local mname = vim.fn.input('Module: ', '*')
        local prof = require 'profile'
        if prof.is_recording() then
          prof.stop()
          vim.ui.input({ prompt = 'Save profile to:', completion = 'file', default = 'profile.json' }, function(filename)
            if filename then
              prof.export(filename)
              vim.notify(string.format('Wrote %s', filename))
            end
          end)
        else
          prof.instrument_autocmds()
          prof.instrument '*'
          prof.start(mname)
        end
      end
      vim.keymap.set('n', '<leader>op', toggle_profile, { desc = 'Toggle Profiler' })
    end,
  },
}
