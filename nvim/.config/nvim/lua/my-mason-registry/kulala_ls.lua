local Pkg = require 'mason-core.package'
local _ = require 'mason-core.functional'

local spec = {
  schema = 'registry+v1',
  name = 'kulala_ls',
  description = 'A minimal language server for HTTP syntax',
  homepage = 'https://github.com/mistweaverco/kulala-ls',
  licenses = { 'MIT' },
  languages = { 'http' },
  categories = { 'LSP' },
  source = {
    id = 'pkg:npm/@mistweaverco/kulala-ls@1.9.0',
  },
  bin = {
    ['kulala-ls'] = 'npm:kulala-ls',
  },
}
spec.desc = spec.description

-- hydrate Pkg.Lang index
_.each(function(lang)
  local _ = Pkg.Lang[lang]
end, spec.languages)

return Pkg.new(spec)
