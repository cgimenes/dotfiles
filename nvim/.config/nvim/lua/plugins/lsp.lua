vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' }
vim.lsp.enable {
  'clangd',
  'cssls',
  'emmet_language_server',
  'gopls',
  'intelephense',
  'jsonls',
  'lua_ls',
  'prismals',
  'pyright',
  'ruby_lsp',
  'ruff',
  'tailwindcss',
  'taplo', -- TOML
  'yamlls',
}

-- JSON schemas
vim.pack.add { 'https://github.com/b0o/schemastore.nvim' }

-- Typescript LSP
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/pmizio/typescript-tools.nvim',
}
require('typescript-tools').setup {}
Map { '<leader>lg', '<cmd>TSToolsGoToSourceDefinition<cr>', desc = 'TS: Go to Source Definition' }

-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
-- used for completion, annotations and signatures of Neovim apis
vim.pack.add { 'https://github.com/folke/lazydev.nvim' }
require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    { path = 'snacks.nvim', words = { 'Snacks' } },
  },
}

-- Breadcrumbs
vim.pack.add { 'https://github.com/Bekaboo/dropbar.nvim' }

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
