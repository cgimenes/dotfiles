vim.pack.add { 'https://github.com/vim-test/vim-test' }

local function OverseerStrategy(cmd)
  local task = require('overseer.task').new {
    cmd = cmd,
    components = {
      'keymaps',
      'on_exit_set_status',
      { 'open_output', direction = 'vertical', on_start = 'never', on_complete = 'failure' },
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
    vim.cmd 'silent! wa'
    vim.cmd 'TestNearest'
  end,
  desc = 'Test Nearest',
}
Map {
  '<leader>tf',
  function()
    vim.cmd 'silent! wa'
    vim.cmd 'TestFile'
  end,
  desc = 'Test File',
}
Map {
  '<leader>ts',
  function()
    vim.cmd 'silent! wa'
    vim.cmd 'TestSuite'
  end,
  desc = 'Test Suite',
}
Map {
  '<leader>tl',
  function()
    vim.cmd 'silent! wa'
    vim.cmd 'TestLast'
  end,
  desc = 'Test Last',
}
