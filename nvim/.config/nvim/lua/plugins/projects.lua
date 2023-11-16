return {
  {
    'ahmedkhalf/project.nvim',
    config = function ()
      require('project_nvim').setup {
        silence_chdir = false,
      }
      pcall(require('telescope').load_extension, 'projects')

      vim.keymap.set('n', '<leader>p', require('telescope').extensions.projects.projects, { desc = '[P]rojects' })
    end
  }
}
