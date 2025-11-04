function BuildAfterUpdate(plugin_name, build)
  vim.api.nvim_create_autocmd('PackChanged', {
    pattern = '*',
    callback = function(ev)
      if ev.data.spec.name == plugin_name and ev.data.spec.kind ~= 'deleted' then
        vim.notify(plugin_name .. ' was updated, running build', vim.log.levels.INFO)

        if type(build) == 'function' then
          build(ev.data)
        elseif build:sub(1, 1) == ':' then
          local cmd = vim.api.nvim_parse_cmd(build:sub(2), {})
          vim.notify(vim.api.nvim_cmd(cmd, { output = true }), vim.log.levels.INFO)
        else
          vim.notify('You will need to go to ' .. ev.data.path .. ' and run: ' .. build, vim.log.levels.WARN)
        end
      end
    end,
  })
end

-- Order matters
require 'plugins/lazy'
require 'plugins/colorschemes'
require 'plugins/snacks'
require 'plugins/appearance'
require 'plugins/treesitter'
require 'plugins/mason'
require 'plugins/lsp'
require 'plugins/autocompletion'
require 'plugins/runner'
require 'plugins/debug'
require 'plugins/grapple'
require 'plugins/lualine'
require 'plugins/format'
require 'plugins/git'

-- Order doesn't matter
require 'plugins/abolish'
require 'plugins/ai'
require 'plugins/around-inside'
require 'plugins/autopairs'
require 'plugins/colorizer'
require 'plugins/db'
require 'plugins/explorer'
require 'plugins/filetypes'
require 'plugins/flash'
require 'plugins/fzf'
require 'plugins/guess-indent'
require 'plugins/http-client'
require 'plugins/lastplace'
require 'plugins/markdown'
require 'plugins/rails'
require 'plugins/refactoring'
require 'plugins/find-replace'
require 'plugins/snippets'
require 'plugins/surround'
require 'plugins/swap'
require 'plugins/terminal'
require 'plugins/tests'
require 'plugins/tmux'
require 'plugins/todo-comments'
require 'plugins/which'
require 'plugins/experimentation'
require 'plugins/builtin'
