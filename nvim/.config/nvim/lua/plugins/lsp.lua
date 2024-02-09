return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      -- Breadcrumbs
      {
        "SmiteshP/nvim-navic",
        opts = {
          highlight = true
        },
      },

      -- JSON schemas
      "b0o/schemastore.nvim",

    },
    config = function()
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          local navic = require("nvim-navic")
          navic.attach(client, bufnr)
        end

        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>lr', vim.lsp.buf.rename, '[R]ename')
        nmap('<leader>la', vim.lsp.buf.code_action, 'Code [A]ction')
        nmap('<leader>lf', vim.lsp.buf.format, '[F]ormat')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>ld', require('telescope.builtin').lsp_document_symbols, '[D]ocument Symbols')
        nmap('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')

        -- Diagnostic keymaps
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
        vim.keymap.set('n', '<leader>lm', vim.diagnostic.open_float, { desc = 'Open floating diagnostic [M]essage' })
        vim.keymap.set('n', '<leader>lD', function()
          vim.diagnostic.config({
            virtual_text = false,
            underline = false,
          })
        end, { desc = '[D]isable diagnostic virtual text' })
        vim.keymap.set('n', '<leader>lR', function()
          vim.diagnostic.config({
            virtual_text = true,
            underline = true,
          })
        end, { desc = '[E]nable diagnostic virtual text' })

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        vim.keymap.set({'i', 'n'}, '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })
      end

      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      require('mason').setup()
      require('mason-lspconfig').setup()
      local servers = {
        jsonls = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        intelephense = {},
      }

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }

      local diagnostic_config = {
        signs = true,
        virtual_text = false,
        update_in_insert = false,
        underline = false,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }

      vim.diagnostic.config(diagnostic_config)

      local signs = {
        { name = "DiagnosticSignError", text = '' },
        { name = "DiagnosticSignWarn", text = '' },
        { name = "DiagnosticSignHint", text = '󰌶' },
        { name = "DiagnosticSignInfo", text = '' },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end
    end
  },
  {
    -- Diagnostics list
    "folke/trouble.nvim",
    opts = {
      cycle_results = false,
    },
    keys = {
      { '<leader>lt', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics' },
      { 'gR', '<cmd>Trouble lsp_references<cr>', desc = 'Symbol References' },
      { 'gI', '<cmd>Trouble lsp_implementations<cr>', desc = 'Symbol Implementations' },
    },
    cmd = {
      "Trouble",
      "TroubleClose",
      "TroubleToggle",
      "TroubleRefresh",
    },
  },
}
