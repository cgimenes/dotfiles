return {
  {
    'stevearc/overseer.nvim',
    opts = {
      dap = false,
      task_list = {
        bindings = {
          ['K'] = 'ScrollOutputUp',
          ['J'] = 'ScrollOutputDown',
          ['<C-k>'] = false,
          ['<C-j>'] = false,
        },
      },
    },
    keys = {
      { '<leader>rr', '<cmd>OverseerRun<cr>', desc = 'Overseer [R]un' },
      { '<leader>rt', '<cmd>OverseerToggle<cr>', desc = 'Overseer [T]oggle' },
    },
  },
}
