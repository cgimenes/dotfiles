return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
      -- JSON schemas
      'b0o/schemastore.nvim',
    },
    config = function()
      require('mason-lspconfig').setup()
      vim.lsp.enable {
        'clangd',
        'cssls',
        'emmet_language_server',
        'gopls',
        'intelephense',
        'prismals',
        'pyright',
        'ruby_lsp',
        'tailwindcss',
        'taplo', -- TOML
      }
      vim.lsp.config('jsonls', {
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
      })
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      })
      vim.lsp.config('ruff', {
        autostart = false, -- Disable ruff LSP
      })
      vim.lsp.config('yamlls', {
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
      })
    end,
  },
  {
    'Bekaboo/dropbar.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    keys = {
      {
        '<leader>;',
        function()
          require('dropbar.api').pick()
        end,
        desc = 'Pick symbols in winbar',
      },
      {
        '[;',
        function()
          require('dropbar.api').goto_context_start()
        end,
        desc = 'Go to start of current context',
      },
      {
        '];',
        function()
          require('dropbar.api').select_next_context()
        end,
        desc = 'Select next context',
      },
    },
  },
}
