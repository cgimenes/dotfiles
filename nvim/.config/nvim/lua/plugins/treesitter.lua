BuildAfterUpdate('nvim-treesitter', ':TSUpdate')
vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/MeanderingProgrammer/treesitter-modules.nvim',
}
require('treesitter-modules').setup {
  ensure_installed = {
    'javascript',
    'tsx',
    'typescript',
    'prisma',
  },
  ignore_install = {},
  sync_install = false,
  auto_install = false,
  highlight = { enable = { 'prisma' } },
  indent = { enable = false },
  fold = { enable = true },
}

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
