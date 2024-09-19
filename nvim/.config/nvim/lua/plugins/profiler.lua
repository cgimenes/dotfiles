return {
  {
    'stevearc/profile.nvim',
    event = 'VeryLazy',
    config = function()
      local function toggle_profile()
        local prof = require 'profile'
        if prof.is_recording() then
          prof.stop()
          vim.ui.input({ prompt = 'Save profile to: ', completion = 'file', default = 'profile.json' }, function(filename)
            if filename then
              prof.export(filename)
              vim.notify(string.format('Wrote %s', filename))
            end
          end)
        else
          local mname = vim.fn.input('Module: ', '*')
          prof.instrument_autocmds()
          prof.instrument '*'
          prof.start(mname)
        end
      end
      vim.keymap.set('n', '<leader>oP', toggle_profile, { desc = 'Toggle Profiler' })
    end,
  },
}
