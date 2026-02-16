local excluded_filetypes = {
  'gitcommit',
  'oil',
}

vim.pack.add { 'https://github.com/okuuva/auto-save.nvim' }
require('auto-save').setup {
  condition = function(buf)
    if vim.tbl_contains(excluded_filetypes, vim.fn.getbufvar(buf, '&filetype')) then
      return false
    end
    return true
  end,
}
