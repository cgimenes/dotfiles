return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        version = '^1.0.0',
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      local telescopeConfig = require 'telescope.config'
      local telescopeStrategies = require 'telescope.pickers.layout_strategies'
      local actions = require 'telescope.actions'
      local open_with_trouble = require('trouble.sources.telescope').open
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, '--hidden')
      table.insert(vimgrep_arguments, '--glob')
      table.insert(vimgrep_arguments, '!**/vendor/*')

      telescopeStrategies.vertical_merged = function(picker, max_columns, max_lines, layout_config)
        local layout = require('telescope.pickers.layout_strategies').vertical(picker, max_columns, max_lines, layout_config)
        layout.results.line = layout.results.line - 1
        layout.results.height = layout.results.height + 1
        layout.results.title = ''
        layout.results.borderchars = { '─', '│', '─', '│', '├', '┤', '╯', '╰' }
        return layout
      end

      require('telescope').setup {
        defaults = {
          prompt_prefix = ' ',
          selection_caret = ' ',
          vimgrep_arguments = vimgrep_arguments,
          mappings = {
            i = {
              ['<C-d>'] = actions.delete_buffer,
              ['<c-t>'] = open_with_trouble,
              ['<esc>'] = actions.close,
            },
            n = {
              ['dd'] = actions.delete_buffer,
              ['<c-t>'] = open_with_trouble,
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
          sorting_strategy = 'ascending',
        },
        pickers = {
          lsp_references = {
            show_line = false,
          },
          lsp_implementations = {
            show_line = false,
          },
          lsp_document_symbols = {
            symbol_width = 50,
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      require('telescope').load_extension 'live_grep_args'

      local function find_files(check_oil)
        return function()
          opts = {}
          opts.find_command = {
            'rg',
            '--files',
            '--glob',
            '!**/.cache/*',
            '--glob',
            '!**/.git/*',
            '--glob',
            '!**/.npm/*',
            '--glob',
            '!**/vendor/*',
            '--glob',
            '!**/node_modules/*',
            '--glob',
            '!**/.local/share/*',
            '--hidden',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          }
          if check_oil and vim.bo.filetype == 'oil' then
            local basedir = require('oil').get_current_dir()
            opts.cwd = basedir
            opts.search_dirs = { basedir }
          end
          require('telescope.builtin').find_files(opts)
        end
      end

      vim.keymap.set('n', '<leader>bl', require('telescope.builtin').buffers, { desc = '[L]ist existing buffers' })
      vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = 'Search [R]ecently opened files' })
      vim.keymap.set('n', '<leader>fF', find_files(false), { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>.', find_files(true), { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', function()
        local command = '""<Esc>i'
        if vim.bo.filetype == 'oil' then
          local basedir = require('oil').get_current_dir()
          command = string.format('"" %s<Esc>_3li', basedir)
        end

        require('telescope').extensions.live_grep_args.live_grep_args()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(command, true, true, true), 'n')
      end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>lT', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
      vim.keymap.set('n', '<leader>sl', require('telescope.builtin').resume, { desc = '[S]earch Resume' })
      vim.keymap.set('n', '<leader>oc', require('telescope.builtin').colorscheme, { desc = '[S]earch Colorschemes' })
      vim.keymap.set('n', '<leader>of', '<cmd>Telescope filetypes<cr>', { desc = 'Change [F]iletype' })
    end,
  },
}
