vim.api.nvim_create_user_command('FixJson', function()
  vim.opt.filetype = 'json'

  command = ':silent! %s/\\\\"/"/g<cr>'
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes(command, true, true, true), 'n')

  command = ':silent! %s/^"//<cr>'
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes(command, true, true, true), 'n')

  command = ':silent! %s/"$//<cr>'
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes(command, true, true, true), 'n')

  command = ':silent! %s/"$//<cr>'
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes(command, true, true, true), 'n')
end, {})
