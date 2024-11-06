return {
  {
    'stevearc/profile.nvim',
    keys = {
      {
        '<leader>oP',
        function()
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
        end,
        desc = 'Toggle Profiler',
      },
    },
  },
}
