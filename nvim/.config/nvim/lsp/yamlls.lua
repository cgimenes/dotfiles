vim.pack.add { 'gh:b0o/schemastore.nvim' }

return {
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
}
