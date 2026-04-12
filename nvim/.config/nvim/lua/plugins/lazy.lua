vim.pack.add { 'gh:lumen-oss/lz.n' }

function LazyLoad(plugin)
  require('lz.n').load(plugin)
end
