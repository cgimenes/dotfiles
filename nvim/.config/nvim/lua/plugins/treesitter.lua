return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'diff',
        'go',
        'html',
        'javascript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'php',
        'python',
        'query',
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
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      -- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      -- keymaps:
      --   - init_selection: in normal mode, start incremental selection.
      --     Defaults to `gnn`.
      --   - node_incremental: in visual mode, increment to the upper named parent.
      --     Defaults to `grn`.
      --   - scope_incremental: in visual mode, increment to the upper scope
      --     (as defined in `locals.scm`). Defaults to `grc`.
      --   - node_decremental: in visual mode, decrement to the previous named node.
      --     Defaults to `grm`.
      incremental_selection = {
        enable = true,
      },
    },
    -- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
    },
    config = function(_, opts)
      require('ts_context_commentstring').setup(opts)

      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
      end
    end,
  },
  {
    -- Use treesitter to autoclose and autorename html tag
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = true,
  },
  {
    -- Splitting/joining blocks of code
    'Wansmer/treesj',
    keys = {
      { '<space>lm', '<cmd>TSJToggle<cr>', desc = 'Split or Join code block with autodetect' },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}
