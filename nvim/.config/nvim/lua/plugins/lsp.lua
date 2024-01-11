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
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>ld', require('telescope.builtin').lsp_document_symbols, '[D]ocument Symbols')
        nmap('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')

        -- Diagnostic keymaps
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
        vim.keymap.set('n', '<leader>lm', vim.diagnostic.open_float, { desc = 'Open floating diagnostic [M]essage' })

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
      end

      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      require('mason').setup()
      require('mason-lspconfig').setup()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to the map in question.
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
        virtual_text = {
          spacing = 4,
          source = "if_many",
          format = function(diagnostic)
            if #diagnostic.message > 50 then
              return diagnostic.message:sub(1, 50) .. "..."
            end
            return diagnostic.message
          end,
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        update_in_insert = false,
        underline = true,
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
        { name = "DiagnosticSignError", text = ' ' },
        { name = "DiagnosticSignWarn", text = ' ' },
        { name = "DiagnosticSignHint", text = ' 󰌶' },
        { name = "DiagnosticSignInfo", text = ' ' },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end
    end
  },
}
