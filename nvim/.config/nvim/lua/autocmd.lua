-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Use q to close certain windows
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('CloseWithQ', { clear = true }),
  command = [[nnoremap <buffer> q <cmd>q<cr>]],
  pattern = {
    'fugitive',
    'fugitiveblame',
    'gitsigns-blame',
    'grug-far',
    'help',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'qf',
    'spectre_panel',
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

-- Terminal keymap
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-terminal', { clear = true }),
  callback = function(event)
    vim.keymap.set('n', 'gf', '<c-w>sgF<c-w>H<c-w>l<c-w>q', { buffer = event.buf })
  end,
})

-- Disable automatic comment insertion on new lines
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('no-comment', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { 'o' }
  end,
})

-- Setup some LSP features
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('grvd', '<cmd>vsplit<cr><cmd>lua vim.lsp.buf.definition()<cr>', 'Goto Definition')
    map('<leader>li', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>', 'Incoming Calls')
    map('grn', function()
      vim.lsp.buf.rename()
      vim.cmd 'silent wa'
    end, 'Rename')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, { bufnr = event.buf }) then
      local highlight_augroup = vim.api.nvim_create_augroup('highlight-references', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'highlight-references', buffer = event.buf }
        end,
      })
    end
  end,
})

-- Keep at least `scrolloff` lines below the cursor when at the end of the file
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('ScrollOffEOF', {}),
  callback = function()
    local win_h = vim.api.nvim_win_get_height(0)
    local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
    local dist = vim.fn.line '$' - vim.fn.line '.'
    local rem = vim.fn.line 'w$' - vim.fn.line 'w0' + 1
    if dist < off and win_h - rem + dist < off then
      local view = vim.fn.winsaveview()
      view.topline = view.topline + off - (win_h - rem + dist)
      vim.fn.winrestview(view)
    end
  end,
})
