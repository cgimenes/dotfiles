---@type overseer.TemplateDefinition
return {
  name = 'rails dev',
  builder = function()
    ---@type overseer.TaskDefinition
    return { cmd = 'bin/dev' }
  end,
  condition = {
    callback = function()
      return vim.fn.filereadable 'bin/dev' == 1
    end,
  },
}
