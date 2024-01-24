return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      local telescopeConfig = require("telescope.config")
      local telescopeStrategies = require('telescope.pickers.layout_strategies')
      local actions = require("telescope.actions")
      local trouble = require("trouble.providers.telescope")
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/vendor/*")

      telescopeStrategies.vertical_merged = function(picker, max_columns, max_lines, layout_config)
        local layout = require('telescope.pickers.layout_strategies').vertical(picker, max_columns, max_lines,
          layout_config)
        layout.results.line = layout.results.line - 1
        layout.results.height = layout.results.height + 1
        layout.results.title = ''
        layout.results.borderchars = { '─', '│', '─', '│', '├', '┤', "╯", "╰" }
        return layout
      end

      require('telescope').setup {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          vimgrep_arguments = vimgrep_arguments,
          mappings = {
            i = {
              ['<C-d>'] = actions.delete_buffer,
              ["<c-t>"] = trouble.open_with_trouble,
              ["<esc>"] = actions.close,
            },
            n = {
              ["dd"] = actions.delete_buffer,
              ["<c-t>"] = trouble.open_with_trouble,
            },
          },
          layout_strategy = 'vertical_merged',
          layout_config = {
            vertical = {
              width = 0.9,
              height = 0.9,
              prompt_position = 'top',
              mirror = true,
              preview_cutoff = 30,
              preview_height = 0.6,
            },
          },
          sorting_strategy = 'ascending'
        },
        pickers = {
          lsp_references = {
            show_line = false,
            initial_mode = 'normal',
          },
          lsp_implementations = {
            show_line = false,
            initial_mode = 'normal',
          },
          lsp_document_symbols = {
            symbol_width = 50,
          },
          colorscheme = {
            enable_preview = true,
          }
        }
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      local function buffer_fuzzy_find()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end

      local function find_files()
        require('telescope.builtin').find_files {
          find_command = {
            'rg',
            '--files',
            '--glob', '!**/pkg/*',
            '--glob', '!**/.cache/*',
            '--glob', '!**/.git/*',
            '--glob', '!**/.npm/*',
            '--glob', '!**/vendor/*',
            '--glob', '!**/node_modules/*',
            '--glob', '!**/.local/share/*',
            '--hidden',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
        }
      end

      vim.keymap.set('n', '<leader>bf', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles,
        { desc = 'Search [R]ecently opened files' })
      vim.keymap.set('n', '<leader>s/', buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>sf', find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sl', require('telescope.builtin').resume, { desc = '[S]earch Resume' })
      vim.keymap.set('n', '<leader>sc', require('telescope.builtin').colorscheme, { desc = '[S]earch Colorschemes' })
    end
  },
}
