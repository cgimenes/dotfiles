-- Copilot
-- BuildAfterUpdate('copilot.lua', ':Copilot auth')
-- vim.pack.add { 'gh:zbirenbaum/copilot.lua' }
-- require('copilot').setup {
--   suggestion = { enabled = false },
--   panel = { enabled = false },
-- }

-- Sidekick
vim.pack.add { 'https://github.com/folke/sidekick.nvim' }
local function read_prompt_files()
  local prompt_path = vim.fn.stdpath 'config' .. '/prompts/'
  local p = io.popen('ls ' .. prompt_path)
  local prompts = {}
  if not p then return prompts end

  for file_name in p:lines() do
    local f = io.open(prompt_path .. file_name, 'r')
    if f then
      prompts[file_name] = f:read '*a'
      f:close()
    end
  end
  return prompts
end
require('sidekick').setup {
  nes = { enabled = false },
  cli = {
    mux = { backend = 'tmux', enabled = true },
    prompts = read_prompt_files(),
  },
}
Map {
  '<leader>an',
  function() require('sidekick').nes_jump_or_apply() end,
  desc = 'Goto/Apply Next Edit Suggestion',
}
Map {
  '<leader>aN',
  function() require('sidekick.nes').toggle() end,
  desc = 'Toggle Sidekick NES',
}
Map {
  '<leader>aa',
  function() require('sidekick.cli').toggle { name = 'claude' } end,
  desc = 'Sidekick Toggle CLI',
}
Map {
  '<leader>at',
  function() require('sidekick.cli').send { name = 'claude', msg = '{this}' } end,
  mode = { 'x', 'n' },
  desc = 'Sidekick Send This',
}
Map {
  '<leader>af',
  function() require('sidekick.cli').send { name = 'claude', msg = '{file}' } end,
  desc = 'Sidekick Send File',
}
Map {
  '<leader>av',
  function() require('sidekick.cli').send { name = 'claude', msg = '{selection}' } end,
  mode = { 'x' },
  desc = 'Sidekick Send Visual Selection',
}
Map {
  '<leader>ap',
  function() require('sidekick.cli').prompt { name = 'claude' } end,
  mode = { 'n', 'x' },
  desc = 'Sidekick Select Prompt',
}
