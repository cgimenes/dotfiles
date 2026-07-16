LazyLoad {
  'leetcode.nvim',
  cmd = 'Leet',
  after = function()
    vim.pack.add {
      'gh:kawre/leetcode.nvim',
      'gh:nvim-lua/plenary.nvim',
      'gh:MunifTanjim/nui.nvim',
    }
    require('leetcode').setup {
      lang = 'typescript',
      plugins = {
        non_standalone = true,
      },
    }
  end,
}

