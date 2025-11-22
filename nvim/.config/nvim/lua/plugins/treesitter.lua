-- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'c',
    'css',
    'csv',
    'diff',
    'dockerfile',
    'go',
    'html',
    'javascript',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'php',
    'python',
    'rasi',
    'ruby',
    'sql',
    'sxhkdrc',
    'tmux',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
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
  -- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  -- - init_selection: in normal mode, start incremental selection.
  -- - node_incremental: in visual mode, increment to the upper named parent.
  -- - scope_incremental: in visual mode, increment to the upper scope
  -- - node_decremental: in visual mode, decrement to the previous named node.
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gii',
      node_incremental = 'gin',
      scope_incremental = 'gis',
      node_decremental = 'gid',
    },
  },
}
BuildAfterUpdate('nvim-treesitter', ':TSUpdate')

-- setting the commentstring option based on the cursor location in the file.
vim.pack.add { 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring' }
require('ts_context_commentstring').setup { enable_autocmd = false }
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
end

-- Use treesitter to autoclose and autorename html tag
vim.pack.add { 'https://github.com/windwp/nvim-ts-autotag' }
require('nvim-ts-autotag').setup {}

-- Splitting/joining blocks of code
vim.pack.add { 'https://github.com/Wansmer/treesj' }
require('treesj').setup { use_default_keymaps = false }
Map { '<space>lm', '<cmd>TSJToggle<cr>', desc = 'Split or Join code block with autodetect' }
