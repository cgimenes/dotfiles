vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap-python',
  'https://github.com/mfussenegger/nvim-dap',
}

local dap = require 'dap'

require('overseer').enable_dap()

require('dap-python').setup 'uv'
require('debugger.php').setup()
require('debugger.javascript').setup()
require('debugger.c').setup()
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
  function()
    require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end,
  desc = 'Breakpoint Condition',
}
Map {
  '<leader>dC',
  function()
    require('dap').run_to_cursor()
  end,
  desc = 'Run to Cursor',
}
Map {
  '<leader>dK',
  function()
    require('dap.ui.widgets').hover(nil, { border = 'rounded' })
  end,
  desc = 'Eval',
}
Map {
  '<leader>dP',
  function()
    require('dap').pause()
  end,
  desc = 'Pause',
}
Map {
  '<leader>dT',
  function()
    require('dap').terminate()
  end,
  desc = 'Terminate',
}
Map {
  '<leader>db',
  function()
    require('dap').toggle_breakpoint()
  end,
  desc = 'Toggle Breakpoint',
}
Map {
  '<leader>dc',
  function()
    require('dap').continue()
  end,
  desc = 'Run/Continue',
}
Map {
  '<leader>dd',
  function()
    require('dap').down()
  end,
  desc = 'Down in stacktrace',
}
Map {
  '<leader>dg',
  function()
    require('dap').goto_()
  end,
  desc = 'Go to Line (No Execute)',
}
Map {
  '<leader>di',
  function()
    require('dap').step_into()
  end,
  desc = 'Step Into',
}
Map {
  '<leader>dj',
  function()
    require('dap').down()
  end,
  desc = 'Down',
}
Map {
  '<leader>dk',
  function()
    require('dap').up()
  end,
  desc = 'Up',
}
Map {
  '<leader>dl',
  function()
    require('dap').run_last()
  end,
  desc = 'Run Last',
}
Map {
  '<leader>dn',
  function()
    require('dap').step_over()
  end,
  desc = 'Step Over',
}
Map {
  '<leader>do',
  function()
    require('dap').step_out()
  end,
  desc = 'Step Out',
}
Map {
  '<leader>du',
  function()
    require('dap').up()
  end,
  desc = 'Up in stacktrace',
}

-- DAP UI
vim.pack.add { 'https://github.com/igorlfs/nvim-dap-view' }
require('dap-view').setup {
  auto_toggle = true,
  windows = {
    terminal = {
      position = 'right',
    },
  },
}
Map { '<leader>dU', '<cmd>DapViewToggle!<cr>', desc = 'Dap UI' }

vim.pack.add { 'https://github.com/theHamsta/nvim-dap-virtual-text' }
require('nvim-dap-virtual-text').setup {}

-- Hydra
vim.pack.add { 'https://github.com/nvimtools/hydra.nvim' }
require 'hydra' {
  hint = [[
 _n_: Step Over         _K_: Eval
 _i_: Step Into         ^ ^
 _o_: Step Out          _T_: Terminate
 _C_: To Cursor         _q_: Exit Mode
 _c_: Continue/Start
]],
  config = {
    color = 'pink',
    invoke_on_body = true,
    hint = {
      position = 'top-right',
      offset = 1,
    },
  },
  name = 'DAP mode',
  mode = { 'n', 'x' },
  body = '<leader>dm',
  heads = {
    { 'n', dap.step_over, { silent = true } },
    { 'i', dap.step_into, { silent = true } },
    { 'o', dap.step_out, { silent = true } },
    { 'C', dap.run_to_cursor, { silent = true } },
    { 'c', dap.continue, { silent = true } },
    { 'T', dap.terminate, { exit = true, silent = true } },
    {
      'K',
      function()
        require('dap.ui.widgets').hover(nil, { border = 'rounded' })
      end,
      { silent = true },
    },
    { 'q', nil, { exit = true, nowait = true } },
  },
}
