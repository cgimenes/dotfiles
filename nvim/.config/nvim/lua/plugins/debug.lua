vim.pack.add {
  'gh:mfussenegger/nvim-dap-python',
  'gh:mfussenegger/nvim-dap',
}

local dap = require 'dap'

require('overseer').enable_dap()

require('dap-python').setup 'uv'
require('debugger.php').setup()
require('debugger.javascript').setup()
require('debugger.c').setup()
require('debugger.rust').setup()
require('debugger.ruby').setup()

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text = '●', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', {
  text = '●',
  texthl = 'DapLogPoint',
  linehl = 'DapLogPoint',
  numhl = 'DapLogPoint',
})
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
Map {
  '<leader>dB',
  function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
  desc = 'Breakpoint Condition',
}
Map {
  '<leader>dC',
  function() dap.run_to_cursor() end,
  desc = 'Run to Cursor',
}
Map {
  '<leader>dK',
  function() require('dap.ui.widgets').hover(nil, { border = 'rounded' }) end,
  desc = 'Eval',
}
Map {
  '<leader>dP',
  function() dap.pause() end,
  desc = 'Pause',
}
Map {
  '<leader>dT',
  function()
    dap.terminate { all = true, hierarchy = true }
    vim.cmd 'DapViewClose!'
  end,
  desc = 'Terminate',
}
Map {
  '<leader>db',
  function() dap.toggle_breakpoint() end,
  desc = 'Toggle Breakpoint',
}
Map {
  '<leader>dc',
  function() dap.continue() end,
  desc = 'Run/Continue',
}
Map {
  '<leader>dd',
  function() dap.down() end,
  desc = 'Down in stacktrace',
}
Map {
  '<leader>dg',
  function() dap.goto_() end,
  desc = 'Go to Line (No Execute)',
}
Map {
  '<leader>di',
  function() dap.step_into() end,
  desc = 'Step Into',
}
Map {
  '<leader>dj',
  function() dap.down() end,
  desc = 'Down',
}
Map {
  '<leader>dk',
  function() dap.up() end,
  desc = 'Up',
}
Map {
  '<leader>dl',
  function() dap.run_last() end,
  desc = 'Run Last',
}
Map {
  '<leader>dn',
  function() dap.step_over() end,
  desc = 'Step Over',
}
Map {
  '<leader>do',
  function() dap.step_out() end,
  desc = 'Step Out',
}
Map {
  '<leader>du',
  function() dap.up() end,
  desc = 'Up in stacktrace',
}

-- DAP UI
vim.pack.add { 'gh:igorlfs/nvim-dap-view' }
require('dap-view').setup {
  auto_toggle = true,
  windows = {
    terminal = {
      position = 'right',
    },
  },
}
Map { '<leader>dU', '<cmd>DapViewToggle!<cr>', desc = 'Dap UI' }

-- Debug mode
vim.pack.add { 'gh:debugloop/layers.nvim' }
require('layers').setup {}
local debug_mode = Layers.mode.new()
debug_mode:auto_show_help()
debug_mode:keymaps {
  n = {
    { 'n', dap.step_over, { desc = 'Step Over' } },
    { 'i', dap.step_into, { desc = 'Step Into' } },
    { 'o', dap.step_out, { desc = 'Step Out' } },
    { 'C', dap.run_to_cursor, { desc = 'To Cursor' } },
    { 'c', dap.continue, { desc = 'Continue/Start' } },
    {
      'T',
      function()
        debug_mode:deactivate()
        dap.terminate { all = true, hierarchy = true }
        vim.cmd 'DapViewClose!'
      end,
      { desc = 'Terminate' },
    },
    {
      'K',
      function() require('dap.ui.widgets').hover(nil, { border = 'rounded' }) end,
      { desc = 'Eval' },
    },
    { 'q', function() debug_mode:deactivate() end, { desc = 'Exit Mode' } },
  },
}
dap.listeners.before.event_terminated['debug_mode'] = function() debug_mode:deactivate() end
dap.listeners.before.event_exited['debug_mode'] = function() debug_mode:deactivate() end
Map { '<leader>dm', function() debug_mode:activate() end, desc = 'DAP mode' }
