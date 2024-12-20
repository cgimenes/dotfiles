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
  command = [[nnoremap <buffer> q <cmd>q<cr>]],
  pattern = {
    'spectre_panel',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'help',
    'fugitiveblame',
    'grug-far',
    'qf',
    'fugitive',
  },
})

-- Enable folding with treesitter
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-folding', { clear = true }),
  callback = function()
    if package.loaded['nvim-treesitter.parsers'] then
      if require('nvim-treesitter.parsers').has_parser() then
        vim.opt.foldmethod = 'expr'
        vim.opt.foldlevel = 20
        vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      else
        vim.opt.foldmethod = 'manual'
      end
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

-- Close quickfix menu after selecting choice
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('quickfix-close-with-g<CR>', { clear = true }),
  command = [[nnoremap <buffer> g<CR> <CR>:cclose<CR>]],
  pattern = { 'qf' },
})

-- Better terminal
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-terminal', { clear = true }),
  callback = function ()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})
