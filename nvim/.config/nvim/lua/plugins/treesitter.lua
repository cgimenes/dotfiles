return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'bash',
        'c',
        'cpp',
        'diff',
        'go',
        'html',
        'javascript',
        'lua',
        'luadoc',
        'php',
        'python',
        'rasi',
        'ruby',
        'rust',
        'tsx',
        'typescript',
        'sql',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --    - Incremental selection: Included, see :help nvim-treesitter-incremental-selection-mod
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = { mode = 'cursor', max_lines = 3 },
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
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  {
    'windwp/nvim-ts-autotag',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
  },
}
