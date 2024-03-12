return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'html',
          'c',
          'cpp',
          'go',
          'lua',
          'python',
          'rust',
          'tsx',
          'javascript',
          'typescript',
          'vimdoc',
          'vim',
          'bash',
          'ruby',
          'php',
          'rasi',
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --    - Incremental selection: Included, see :help nvim-treesitter-incremental-selection-mod
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = { mode = 'cursor', max_lines = 3 },
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    keys = {
      {
        '<leader>oc',
        function()
          local tsc = require 'treesitter-context'
          tsc.toggle()
        end,
        desc = 'Toggle Treesitter [C]ontext',
      },
    },
  },
}
