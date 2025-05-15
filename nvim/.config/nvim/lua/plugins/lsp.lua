return {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          registries = {
            'github:mason-org/mason-registry',
            'lua:my-mason-registry',
          },
        },
      }, -- NOTE: Must be loaded before dependants
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- JSON schemas
      'b0o/schemastore.nvim',
    },
    config = function()
      local servers = {
        astro = {},
        clangd = {},
        cssls = {},
        emmet_language_server = {},
        gopls = {},
        intelephense = {},
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        prismals = {},
        pyright = {},
        ruff = { autostart = false }, -- Disable ruff LSP
        tailwindcss = {},
        taplo = {}, -- TOML
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = '',
              },
              schemas = require('schemastore').yaml.schemas {
                select = {
                  'docker-compose.yml',
                  'GitHub Workflow',
                },
              },
              validate = true,
            },
          },
        },
      }
      if vim.fn.executable 'gem' == 1 then
        vim.list_extend(servers, {
          ruby_lsp = {},
        })
      end

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'erb-formatter',
        'js-debug-adapter',
        'kulala-fmt',
        'kulala_ls', -- Isn't supported by mason-lspconfig yet
        'php-cs-fixer',
        'php-debug-adapter',
        'prettier',
        'prettierd',
        'reformat-gherkin',
        'rubocop',
        'ruff',
        'shfmt',
        'sleek',
        'sqlfluff',
        'sqlfmt',
        'stylua',
      })
      if vim.fn.executable 'composer' == 1 then
        vim.list_extend(ensure_installed, { 'pint' })
      end
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if package.loaded['blink.cmp'] then
        capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
      end
      require('mason-lspconfig').setup {
        automatic_enable = true,
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
      require('lspconfig')['kulala_ls'].setup {}

      vim.diagnostic.config {
        virtual_text = {
          current_line = true,
        },
        underline = false,
        severity_sort = true,
        float = {
          focusable = true,
          border = 'rounded',
          header = '',
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '󰌶',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
      }
      vim.keymap.set('n', '<leader>od', function()
        vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
      end, { desc = 'Toggle Diagnostic virtual text' })
    end,
  },
}
