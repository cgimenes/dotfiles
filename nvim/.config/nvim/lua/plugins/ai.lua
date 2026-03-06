-- Copilot
BuildAfterUpdate('copilot.lua', ':Copilot auth')
vim.pack.add { 'https://github.com/zbirenbaum/copilot.lua' }
require('copilot').setup {
  suggestion = { enabled = false },
  panel = { enabled = false },
}

-- Wiremux
local function read_prompt_files()
  local prompt_path = vim.fn.stdpath 'config' .. '/prompts/'
  local p = io.popen('ls ' .. prompt_path)
  local prompts = {}
  if not p then return prompts end

  for file_name in p:lines() do
    local f = io.open(prompt_path .. file_name, 'r')
    if f then
      table.insert(prompts, { label = file_name, value = f:read '*a' })
      f:close()
    end
  end
  return prompts
end

vim.pack.add { 'https://github.com/MSmaili/wiremux.nvim' }
require('wiremux').setup {
  targets = {
    definitions = {
      -- A simple terminal
      terminal = { kind = 'pane', split = 'vertical', size = '20%' },
      -- AI assistants
      copilot = { cmd = 'copilot', kind = 'window', shell = false, size = '30%' },
    },
  },
  picker = {
    adapter = function(items, opts, on_choice)
      vim.ui.select(items, {
        prompt = opts.prompt,
        format_item = opts.format_item,
      }, on_choice)
    end,
  },
}
Map { '<leader>T', function() require('wiremux').toggle { target = 'terminal' } end, desc = 'Toggle terminal' }
Map {
  '<leader>aa',
  function() require('wiremux').toggle { target = 'copilot' } end,
  desc = 'Toggle AI Assistant',
}
Map {
  '<leader>at',
  function() require('wiremux').send { msg = '{this}', target = 'copilot' } end,
  mode = { 'x', 'n' },
  desc = 'Send This to AI Assistant',
}
Map {
  '<leader>af',
  function() require('wiremux').send { msg = '{file}', target = 'copilot' } end,
  desc = 'Send File to AI Assistant',
}
Map {
  '<leader>av',
  function() require('wiremux').send { msg = '{selection}', target = 'copilot' } end,
  mode = { 'x' },
  desc = 'Send Visual Selection to AI Assistant',
}
Map {
  '<leader>ap',
  function()
    local prompts = read_prompt_files()
    local local_prompts = {
      { label = 'Review changes', value = 'Can you review my changes?\n{changes}' },
      {
        label = 'Fix diagnostics',
        value = 'Can you help me fix this?\n{diagnostics}',
        visible = function() return require('wiremux.context').is_available 'diagnostics' end,
      },
      { label = 'Explain', value = 'Explain {this}' },
      { label = 'Write tests', value = 'Can you write tests for {this}?' },
    }

    for _, v in pairs(local_prompts) do
      table.insert(prompts, v)
    end

    require('wiremux').send(prompts, { target = 'copilot' })
  end,
  mode = { 'n', 'x' },
  desc = 'Send Prompt to AI Assistant',
}
