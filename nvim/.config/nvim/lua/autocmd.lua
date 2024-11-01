-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Use q to close certain windows
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('CloseWithQ', { clear = true }),
  callback = function(args)
    vim.keymap.set('n', 'q', '<cmd>q<cr>', { buffer = args.buf })
  end,
  pattern = {
    'spectre_panel',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'help',
    'fugitiveblame',
    'grug-far',
    'qf',
  },
})

-- Enable folding with treesitter
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if require('nvim-treesitter.parsers').has_parser() then
      vim.opt.foldmethod = 'expr'
      vim.opt.foldlevel = 10
      vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    else
      vim.opt.foldmethod = 'manual'
    end
  end,
})

-- Use ctrl-q to send oil selection to quickfix
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('oil-quickfix', { clear = true }),
  callback = function(args)
    vim.keymap.set({ 'n', 'v' }, '<C-q>', function()
      local oil = require 'oil'

      local line_number_start = vim.fn.line 'v'
      local line_number_end = vim.fn.line '.'

      local qf_list = {}

      for i = line_number_start, line_number_end do
        local filename = oil.get_current_dir(args.buf) .. oil.get_entry_on_line(args.buf, i).name
        table.insert(qf_list, { filename = filename })
      end

      vim.fn.setqflist({}, ' ', {
        nr = '$',
        items = qf_list,
        title = 'Oil',
      })

      oil.close()
      vim.cmd 'botright copen'
    end, { buffer = args.buf })
  end,
  pattern = { 'oil' },
})
