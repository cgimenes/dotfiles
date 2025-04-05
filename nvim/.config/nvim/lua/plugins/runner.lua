return {
  {
    'stevearc/overseer.nvim',
    opts = {
      dap = false,
      templates = {
        'builtin',
        'user.run_script',
        'user.rails_dev',
        'user.uv_run',
      },
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
      { '<leader>rr', '<cmd>OverseerRun<cr>', desc = 'Overseer Run' },
      { '<leader>rt', '<cmd>OverseerToggle<cr>', desc = 'Overseer Toggle' },
      { '<leader>rq', '<cmd>OverseerQuickAction<cr>', desc = 'Overseer QuickAction' },
    },
  },
}
