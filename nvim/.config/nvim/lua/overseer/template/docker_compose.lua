---@type overseer.TemplateFileProvider
return {
  generator = function()
    local scripts = {
      'up -d',
      'down',
    }
    local ret = {}
    if vim.fn.filereadable 'docker-compose.yaml' ~= 1 then
      return ret
    end
    for _, script in ipairs(scripts) do
      table.insert(ret, {
        name = 'docker compose: ' .. script,
        builder = function()
          return {
            cmd = { 'docker compose ' .. script },
          }
        end,
      })
    end
    return ret
  end,
}
