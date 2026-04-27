vim.pack.add { 'gh:b0o/schemastore.nvim' }

return {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
