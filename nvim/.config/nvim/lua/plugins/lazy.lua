vim.pack.add { 'https://github.com/lumen-oss/lz.n' }

function LazyLoad(plugin)
  require('lz.n').load(plugin)
end
