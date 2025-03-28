return {
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim', -- required by telescope
      'MunifTanjim/nui.nvim',

      -- optional
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-notify',
    },
    opts = {
      lang = 'python',
      plugins = {
        non_standalone = true,
      },
    },
    keys = {
      { '<leader>Lo', '<cmd>Leet<cr><cmd>Copilot disable<cr>', desc = '[L]eetCode: [O]pen' },
      { '<leader>Ll', '<cmd>Leet list<cr>', desc = '[L]eetCode: [L]ist Questions' },
      { '<leader>Lr', '<cmd>Leet run<cr>', desc = '[L]eetCode: [R]un' },
      { '<leader>Li', '<cmd>Leet info<cr>', desc = '[L]eetCode: Question [I]nfo' },
      { '<leader>Ls', '<cmd>Leet submit<cr>', desc = '[L]eetCode: [S]ubmit' },
      { '<leader>Ld', '<cmd>Leet daily<cr>', desc = '[L]eetCode: Open [D]aily Question' },
      { '<leader>Lq', '<cmd>Leet exit<cr><cmd>Copilot enable<cr>', desc = '[L]eetCode: [Q]uit' },
      { '<leader>Lt', '<cmd>Leet tabs<cr>', desc = '[L]eetCode: [T]abs Picker' },
      { '<leader>LR', '<cmd>Leet random<cr>', desc = '[L]eetCode: Open [R]andom Question' },
      { '<leader>Lb', '<cmd>Leet open<cr>', desc = '[L]eetCode: Open Question on [B]rowser' },
      { '<leader>LS', '<cmd>Leet last_submit<cr>', desc = '[L]eetCode: Retrieve Last [S]ubmit' },
    },
  },
}
