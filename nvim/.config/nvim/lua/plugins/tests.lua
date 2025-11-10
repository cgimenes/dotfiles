vim.pack.add { 'https://github.com/vim-test/vim-test' }

local function OverseerStrategy(cmd)
  local task = require('overseer.task').new {
    cmd = cmd,
    components = {
      'keymaps',
      'on_exit_set_status',
      { 'on_output_quickfix', open_on_exit = 'failure' },
      'unique',
    },
  }
  task:start()
end

vim.g['test#custom_strategies'] = { overseer = OverseerStrategy }
vim.g['test#strategy'] = 'overseer'
vim.g['test#echo_command'] = 0

Map {
  '<leader>tn',
  function()
    vim.api.nvim_command 'silent! wa'
    vim.api.nvim_command 'TestNearest'
  end,
  desc = 'Test Nearest',
}
Map {
  '<leader>tf',
  function()
    vim.api.nvim_command 'silent! wa'
    vim.api.nvim_command 'TestFile'
  end,
  desc = 'Test File',
}
Map {
  '<leader>ts',
  function()
    vim.api.nvim_command 'silent! wa'
    vim.api.nvim_command 'TestSuite'
  end,
  desc = 'Test Suite',
}
Map {
  '<leader>tl',
  function()
    vim.api.nvim_command 'silent! wa'
    vim.api.nvim_command 'TestLast'
  end,
  desc = 'Test Last',
}
