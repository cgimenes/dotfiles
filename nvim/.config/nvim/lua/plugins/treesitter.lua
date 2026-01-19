-- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' } }
require('nvim-treesitter.configs').setup {
  auto_install = false,
  sync_install = false,
  ignore_install = {},
  ensure_installed = {
    'javascript',
    'tsx',
    'typescript',
    'prisma',
  },
  highlight = {
    enable = true,
    disable = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local lang = lang or require('nvim-treesitter.parsers').get_buf_lang(bufnr)
      local langs = { 'prisma' }
      for _, item in pairs(langs) do
        if lang == item then
          return false
        end
      end
      return true
    end,
  },
  indent = {
    enable = false,
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
