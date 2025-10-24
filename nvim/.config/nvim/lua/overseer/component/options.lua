---@type overseer.ComponentFileDefinition
return {
  desc = "Component to set task's buffer options",
  constructor = function(_)
    return {
      on_start = function(_, task)
        vim.keymap.set('n', 'gf', '<c-w>sgF<c-w>H<c-w>l<c-w>q', { buffer = task:get_bufnr() })
        vim.keymap.set('n', 'q', '<c-w>q', { buffer = task:get_bufnr() })
      end,
    }
  end,
}
