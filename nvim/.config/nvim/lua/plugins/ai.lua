-- Copilot
vim.pack.add { 'https://github.com/zbirenbaum/copilot.lua' }
BuildAfterUpdate('copilot.lua', ':Copilot auth')
require('copilot').setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}

-- Sidekick
vim.pack.add { 'https://github.com/folke/sidekick.nvim' }
require('sidekick').setup {
  nes = {
    enabled = false,
  },
  cli = {
    mux = {
      backend = 'tmux',
      enabled = true,
    },
  },
}
Map {
  '<c-n>',
  function()
    -- if there is a next edit, jump to it, otherwise apply it if any
    if not require('sidekick').nes_jump_or_apply() then
      return '<Tab>' -- fallback to normal tab
    end
  end,
  expr = true,
  desc = 'Goto/Apply Next Edit Suggestion',
}
Map {
  '<leader>on',
  function()
    require('sidekick.nes').toggle()
  end,
  desc = 'Toggle Sidekick NES',
}
Map {
  '<leader>aa',
  function()
    require('sidekick.cli').toggle { name = 'copilot' }
  end,
  desc = 'Sidekick Toggle CLI',
}
Map {
  '<leader>at',
  function()
    require('sidekick.cli').send { msg = '{this}' }
  end,
  mode = { 'x', 'n' },
  desc = 'Sidekick Send This',
}
Map {
  '<leader>af',
  function()
    require('sidekick.cli').send { msg = '{file}' }
  end,
  desc = 'Sidekick Send File',
}
Map {
  '<leader>av',
  function()
    require('sidekick.cli').send { msg = '{selection}' }
  end,
  mode = { 'x' },
  desc = 'Sidekick Send Visual Selection',
}
Map {
  '<leader>ap',
  function()
    require('sidekick.cli').prompt()
  end,
  mode = { 'n', 'x' },
  desc = 'Sidekick Select Prompt',
}
