vim.api.nvim_create_user_command('FixJson', function()
  vim.opt.filetype = 'json'

  vim.cmd 'silent! %s/\\\\"/"/g<cr>'
  vim.cmd 'silent! %s/^"//<cr>'
  vim.cmd 'silent! %s/"$//<cr>'
  vim.cmd 'silent! %s/"$//<cr>'
end, {})
