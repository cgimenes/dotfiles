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
  callback = function()
    if require('nvim-treesitter.parsers').has_parser() then
      vim.opt.foldmethod = 'expr'
      vim.opt.foldlevel = 20
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

-- Autostart oil
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('oil-autostart', {}),
  nested = true,
  once = true,
  callback = function()
    -- Don't open if Neovim is opened to show something. That is
    -- when at least one of the following is true:
    -- - There are files in arguments (like `nvim foo.txt` with new file).
    if vim.fn.argc() > 0 then
      return
    end

    -- - Several buffers are listed (like session with placeholder buffers). That
    --   means unlisted buffers (like from `nvim-tree`) don't affect decision.
    local listed_buffers = vim.tbl_filter(function(buf_id)
      return vim.fn.buflisted(buf_id) == 1
    end, vim.api.nvim_list_bufs())
    if #listed_buffers > 1 then
      return
    end

    -- - Current buffer is meant to show something else
    if vim.bo.filetype ~= '' then
      return
    end

    -- - Current buffer has any lines (something opened explicitly).
    -- NOTE: Usage of `line2byte(line('$') + 1) < 0` seemed to be fine, but it
    -- doesn't work if some automated changed was made to buffer while leaving it
    -- empty (returns 2 instead of -1). This was also the reason of not being
    -- able to test with child Neovim process from 'tests/helpers'.
    local n_lines = vim.api.nvim_buf_line_count(0)
    if n_lines > 1 then
      return
    end
    local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
    if string.len(first_line) > 0 then
      return
    end

    vim.cmd 'Oil'
  end,
  desc = 'Open on VimEnter',
})

-- Close quickfix menu after selecting choice
vim.api.nvim_create_autocmd('FileType', {
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
  pattern = { 'qf' },
})
