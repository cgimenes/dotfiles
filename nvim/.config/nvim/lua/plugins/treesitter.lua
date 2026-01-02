-- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
local languages = {}
vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' } }
require('nvim-treesitter.configs').setup {
  ensure_installed = languages,
  auto_install = false,
  highlight = { enable = languages },
  indent = { enable = languages },
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
