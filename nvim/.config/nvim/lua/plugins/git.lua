-- Fugitive
vim.pack.add { 'https://github.com/tpope/vim-fugitive' }
Map { '<leader>gb', '<cmd>G blame<cr>', desc = 'Git Blame' }
Map { '<leader>gc', '<cmd>G mergetool<cr>', desc = 'List Git Conflicts' }
Map { '<leader>gd', '<cmd>vertical G diff %<cr>', desc = 'Git Diff Current File' }

-- Diffview
vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }
require('diffview').setup {}
Map { '<leader>gh', ':DiffviewFileHistory %<cr>', desc = 'File History' }
Map { '<leader>gD', '<cmd>DiffviewOpen<cr>', desc = 'Git Diffview' }

-- Git signs
vim.pack.add { 'https://github.com/nvim-mini/mini.diff' }
require('mini.diff').setup {
  view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '▁' } },
}

-- Octo.nvim (GitHub PRs and Issues)
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/pwntester/octo.nvim',
}
require('octo').setup {
  enable_builtin = true,
  picker = 'snacks',
  use_local_fs = true,
  file_panel = { size = 5 },
  reviews = { auto_show_threads = false },
}
Map { '<leader>gpl', '<cmd>Octo pr list<cr>', desc = 'List' }
Map { '<leader>gpr', '<cmd>Octo review<cr>', desc = 'Review' }
Map { '<leader>gpt', '<cmd>Octo review thread<cr>', desc = 'Show Thread' }

-- Conflicts
vim.pack.add { {
  src = 'https://github.com/akinsho/git-conflict.nvim',
  version = vim.version.range '*',
} }
require('git-conflict').setup { default_mappings = false, default_commands = false }
local group = vim.api.nvim_create_augroup('GitConflictKeymap', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'GitConflictDetected',
  callback = function(event)
    vim.diagnostic.enable(false, { bufnr = event.buf })

    vim.keymap.set('n', ',o', function()
      require('git-conflict').choose 'ours'
    end, { buffer = event.buf, desc = 'Choose ours', silent = true })
    vim.keymap.set('n', ',t', function()
      require('git-conflict').choose 'theirs'
    end, { buffer = event.buf, desc = 'Choose theirs', silent = true })
    vim.keymap.set('n', ',b', function()
      require('git-conflict').choose 'both'
    end, { buffer = event.buf, desc = 'Choose both', silent = true })
    vim.keymap.set('n', ',n', function()
      require('git-conflict').choose 'none'
    end, { buffer = event.buf, desc = 'Choose none', silent = true })
  end,
})
vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'GitConflictResolved',
  callback = function(event)
    vim.diagnostic.enable(true, { bufnr = event.buf })

    for _, mapping in ipairs { ',o', ',t', ',b', ',n' } do
      if vim.fn.hasmapto(mapping, 'n') > 0 then
        vim.api.nvim_buf_del_keymap(event.buf, 'n', mapping)
      end
    end
  end,
})
