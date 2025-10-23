local vim_test_file_types = {
  ['php'] = true,
}
local function use_vim_test()
  if vim_test_file_types[vim.bo.filetype] then
    return true
  end
  return false
end

vim.pack.add {
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-neotest/neotest-vim-test',
  'https://github.com/nvim-neotest/neotest-python',
  'https://github.com/nvim-neotest/neotest-jest',
  'https://github.com/zidhuss/neotest-minitest',
  'https://github.com/preservim/vimux',
  'https://github.com/vim-test/vim-test',
  'https://github.com/nvim-neotest/neotest',
}

vim.cmd "let test#strategy = 'vimux'"
vim.cmd 'let test#echo_command = 0'
vim.g.VimuxCloseOnExit = 1

local neotest = require 'neotest'
neotest.setup {
  output = {
    open_on_run = true,
  },
  status = { virtual_text = true },
  diagnostic = { enabled = false },
  quickfix = {
    open = function()
      vim.cmd 'copen'
    end,
  },
  adapters = {
    require 'neotest-minitest',
    require 'neotest-python' {
      dap = { justMyCode = false },
    },
    require 'neotest-jest' {
      jestCommand = 'npm test --',
      jestConfigFile = 'custom.jest.config.ts',
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    },
  },
  summary = {
    animated = false,
  },
  icons = {
    expanded = ' ',
    non_collapsible = '',
    collapsed = ' ',
  },
}
local neotest_ns = vim.api.nvim_create_namespace 'neotest'
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      -- Replace newline and tab characters with space for more compact diagnostics
      local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
      return message
    end,
  },
}, neotest_ns)
Map {
  '<leader>tn',
  function()
    vim.api.nvim_command 'silent! wa'
    if use_vim_test() then
      vim.api.nvim_command 'TestNearest'
    else
      neotest.run.run()
    end
  end,
  desc = 'Test Nearest',
}
Map {
  '<leader>tf',
  function()
    vim.api.nvim_command 'silent! wa'
    if use_vim_test() then
      vim.api.nvim_command 'TestFile'
    else
      neotest.run.run(vim.fn.expand '%')
    end
  end,
  desc = 'Test File',
}
Map {
  '<leader>ts',
  function()
    vim.api.nvim_command 'silent! wa'
    if use_vim_test() then
      vim.api.nvim_command 'TestSuite'
    else
      neotest.run.run { suite = true }
    end
  end,
  desc = 'Test Suite',
}
Map {
  '<leader>tl',
  function()
    vim.api.nvim_command 'silent! wa'
    if use_vim_test() then
      vim.api.nvim_command 'TestLast'
    else
      neotest.run.run_last()
    end
  end,
  desc = 'Test Last',
}
Map {
  '<leader>tdn',
  function()
    vim.api.nvim_command 'silent! wa'
    neotest.run.run { strategy = 'dap' }
  end,
  desc = 'Debug Nearest',
}
Map {
  '<leader>tdl',
  function()
    vim.api.nvim_command 'silent! wa'
    neotest.run.run_last { strategy = 'dap' }
  end,
  desc = 'Debug Last',
}
Map {
  '<leader>to',
  function()
    neotest.output.open { enter = true, auto_close = true }
  end,
  desc = 'Show Output',
}
Map {
  '<leader>tO',
  function()
    neotest.output_panel.open()
  end,
  desc = 'Show Output Panel',
}
Map {
  '<leader>tu',
  function()
    neotest.summary.toggle()
  end,
  desc = 'Show UI',
}
Map {
  '<leader>tq',
  '<cmd>VimuxCloseRunner<cr>',
  desc = 'Test Quit',
}
