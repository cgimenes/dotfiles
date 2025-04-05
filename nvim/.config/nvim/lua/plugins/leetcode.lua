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
      { '<leader>Lo', '<cmd>Leet<cr><cmd>Copilot disable<cr>', desc = 'LeetCode: Open' },
      { '<leader>Ll', '<cmd>Leet list<cr>', desc = 'LeetCode: List Questions' },
      { '<leader>Lr', '<cmd>Leet run<cr>', desc = 'LeetCode: Run' },
      { '<leader>Li', '<cmd>Leet info<cr>', desc = 'LeetCode: Question Info' },
      { '<leader>Ls', '<cmd>Leet submit<cr>', desc = 'LeetCode: Submit' },
      { '<leader>Ld', '<cmd>Leet daily<cr>', desc = 'LeetCode: Open Daily Question' },
      { '<leader>Lq', '<cmd>Leet exit<cr><cmd>Copilot enable<cr>', desc = 'LeetCode: Quit' },
      { '<leader>Lt', '<cmd>Leet tabs<cr>', desc = 'LeetCode: Tabs Picker' },
      { '<leader>LR', '<cmd>Leet random<cr>', desc = 'LeetCode: Open Random Question' },
      { '<leader>Lb', '<cmd>Leet open<cr>', desc = 'LeetCode: Open Question on Browser' },
      { '<leader>LS', '<cmd>Leet last_submit<cr>', desc = 'LeetCode: Retrieve Last Submit' },
    },
  },
}
