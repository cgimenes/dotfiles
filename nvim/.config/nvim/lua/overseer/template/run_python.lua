---@type overseer.TemplateFileDefinition
return {
  name = 'run script',
  builder = function(params)
    local file = vim.fn.expand '%:p'
    local cmd
    if params['interpreter'] == 'uv' then
      cmd = { 'uv', 'run', file }
    elseif params['interpreter'] == 'python' then
      cmd = { 'python', file }
    end
    return {
      cmd = cmd,
      components = {
        { 'on_output_quickfix', set_diagnostics = true, open = true },
        'on_result_diagnostics',
        -- { 'display_duration', detail_level = 2 },
        'on_exit_set_status',
        { 'on_complete_dispose', require_view = { 'SUCCESS', 'FAILURE' } },
        'unique',
      },
    }
  end,
  params = {
    interpreter = {
      type = 'enum',
      default = 'python',
      choices = { 'python', 'uv' },
    },
  },
  condition = {
    filetype = { 'python' },
  },
}
-- cmd = { 'python', file }
