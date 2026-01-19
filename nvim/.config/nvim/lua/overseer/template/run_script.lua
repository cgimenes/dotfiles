---@module 'overseer'
---@type overseer.TemplateFileDefinition
return {
  name = 'run script',
  builder = function()
    local file = vim.fn.expand '%:p'
    local cmd
    if vim.bo.filetype == 'sh' then
      cmd = { file }
    end
    if vim.bo.filetype == 'go' then
      cmd = { 'go', 'run', file }
    end
    if vim.bo.filetype == 'javascript' then
      cmd = { 'node', file }
    end
    if vim.bo.filetype == 'typescript' then
      cmd = { 'npx', '--yes', 'tsx', file }
    end
    if vim.bo.filetype == 'c' then
      cmd = string.format('clang %s -o a.out -ggdb && ./a.out', vim.fn.expand '%:p')
    end
    if vim.bo.filetype == 'cpp' then
      cmd = string.format('g++ -o a.out -ggdb %s && ./a.out', vim.fn.expand '%:p')
    end
    if vim.bo.filetype == 'ruby' then
      cmd = { 'ruby', file }
    end
    return {
      cmd = cmd,
      components = {
        { 'on_output_quickfix', set_diagnostics = true, open = false },
        'on_result_diagnostics',
        -- { 'display_duration', detail_level = 2 },
        'on_exit_set_status',
        { 'on_complete_dispose', require_view = { 'SUCCESS', 'FAILURE' } },
        'unique',
      },
    }
  end,
  condition = {
    filetype = { 'sh', 'go', 'javascript', 'typescript', 'c', 'cpp', 'ruby' },
  },
}
