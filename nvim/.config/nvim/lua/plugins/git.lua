-- Fugitive
vim.pack.add {
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-fugitive',
}
Map { '<leader>gB', ':GBrowse<cr>', desc = 'Git Browse', mode = { 'n', 'x' } }
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
    if vim.b[event.bufnr].resolve_keymaps_set then return end

    vim.diagnostic.enable(false, { bufnr = event.bufnr })

    vim.keymap.set('n', ']c', '<cmd>ResolveNext<cr>zt', { desc = 'Next conflict', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', '[c', '<cmd>ResolvePrev<cr>zt', { desc = 'Previous conflict', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',O', '<cmd>ResolveOurs<cr>', { desc = 'Choose ours', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',T', '<cmd>ResolveTheirs<cr>', { desc = 'Choose theirs', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',B', '<cmd>ResolveBoth<cr>', { desc = 'Choose both', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',M', '<cmd>ResolveBase<cr>', { desc = 'Choose base', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',N', '<cmd>ResolveNone<cr>', { desc = 'Choose none', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',o', '<cmd>ResolveDiffOurs<cr>', { desc = 'Diff ours', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',t', '<cmd>ResolveDiffTheirs<cr>', { desc = 'Diff theirs', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',b', '<cmd>ResolveDiffBoth<cr>', { desc = 'Diff both', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',v', '<cmd>ResolveDiffOursTheir<cr>', { desc = 'Diff ours → theirs', buffer = event.bufnr, silent = true })
    vim.keymap.set('n', ',V', '<cmd>ResolveDiffTheirsOurs<cr>', { desc = 'Diff theirs → ours', buffer = event.bufnr, silent = true })

    vim.b[event.bufnr].resolve_keymaps_set = true
  end,
  on_conflicts_resolved = function(event)
    if not vim.b[event.bufnr].resolve_keymaps_set then return end

    vim.diagnostic.enable(true, { bufnr = event.bufnr })

    for _, mapping in ipairs { ']c', '[c', ',O', ',T', ',B', ',M', ',N', ',o', ',t', ',b', ',v', ',V' } do
      if vim.fn.hasmapto(mapping, 'n') > 0 then vim.api.nvim_buf_del_keymap(event.bufnr, 'n', mapping) end
    end

    vim.b[event.bufnr].resolve_keymaps_set = nil
  end,
}
