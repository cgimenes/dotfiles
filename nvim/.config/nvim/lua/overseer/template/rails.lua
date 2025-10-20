---@type overseer.TemplateFileProvider
return {
  generator = function()
    local scripts = {
      'bin/dev',
    }
    local ret = {}
    for _, filename in ipairs(scripts) do
      if vim.fn.filereadable 'bin/dev' == 1 then
        table.insert(ret, {
          name = 'rails: ' .. filename,
          builder = function()
            return {
              cmd = { filename },
            }
          end,
        })
      end
    end
    return ret
  end,
}
