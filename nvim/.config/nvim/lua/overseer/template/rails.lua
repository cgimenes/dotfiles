---@type overseer.TemplateFileProvider
return {
  generator = function()
    local scripts = {
      { 'bin/dev' },
      { 'bin/bundle', 'install' },
      { 'bin/rails', 'db:migrate' },
    }
    local ret = {}
    for _, script in ipairs(scripts) do
      if vim.fn.filereadable(script[1]) == 1 then
        table.insert(ret, {
          name = 'rails: ' .. table.concat(script, ' '),
          builder = function()
            return {
              cmd = script,
            }
          end,
        })
      end
    end
    return ret
  end,
}
