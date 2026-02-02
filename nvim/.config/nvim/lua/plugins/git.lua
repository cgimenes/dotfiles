-- Fugitive
vim.pack.add { 'https://github.com/tpope/vim-fugitive' }
Map { '<leader>gb', '<cmd>G blame<cr>', desc = 'Git Blame' }
Map { '<leader>gc', '<cmd>G mergetool<cr>', desc = 'List Git Conflicts' }
Map { '<leader>gd', '<cmd>vertical G diff HEAD %<cr>', desc = 'Git Diff Current File' }

-- CodeDiff
vim.pack.add {
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/esmuellert/codediff.nvim',
}
Map { '<leader>gh', ':CodeDiff history %<cr>', desc = 'File History' }
Map { '<leader>gD', '<cmd>CodeDiff<cr>', desc = 'Git Diffview' }

-- Git signs (textobjects and hunk actions: gh to apply and gH to reset)
vim.pack.add { 'https://github.com/nvim-mini/mini.diff' }
require('mini.diff').setup {
  view = { style = 'sign', signs = { add = '┃', change = '┃', delete = '▁' } },
}
Map {
  '<leader>ho',
  MiniDiff.toggle_overlay,
  desc = 'Toggle Git Changes Overlay',
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
vim.pack.add { 'https://github.com/spacedentist/resolve.nvim' }
require('resolve').setup {
  default_keymaps = false,
  on_conflict_detected = function(event)
    vim.diagnostic.enable(false, { bufnr = event.bufnr })

    vim.keymap.set('n', ']c', '<Plug>(resolve-next)', { desc = 'Next conflict', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', '[c', '<Plug>(resolve-prev)', { desc = 'Previous conflict', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',o', '<Plug>(resolve-ours)', { desc = 'Choose ours', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',t', '<Plug>(resolve-theirs)', { desc = 'Choose theirs', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',b', '<Plug>(resolve-both)', { desc = 'Choose both', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',m', '<Plug>(resolve-base)', { desc = 'Choose base', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',n', '<Plug>(resolve-none)', { desc = 'Choose none', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',do', '<Plug>(resolve-diff-ours)', { desc = 'Diff ours', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',dt', '<Plug>(resolve-diff-theirs)', { desc = 'Diff theirs', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',db', '<Plug>(resolve-diff-both)', { desc = 'Diff both', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',dv', '<Plug>(resolve-diff-vs)', { desc = 'Diff ours → theirs', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',dV', '<Plug>(resolve-diff-vs-reverse)', { desc = 'Diff theirs → ours', buffer = event.bufnr, silent = true })
  end,
  on_conflicts_resolved = function(event)
    vim.diagnostic.enable(true, { bufnr = event.bufnr })

    for _, mapping in ipairs { ']c', '[c', ',o', ',t', ',b', ',m', ',n', ',do', ',dt', ',db', ',dv', ',dV' } do
      if vim.fn.hasmapto(mapping, 'n') > 0 then
        vim.api.nvim_buf_del_keymap(event.bufnr, 'n', mapping)
      end
    end
  end,
}
