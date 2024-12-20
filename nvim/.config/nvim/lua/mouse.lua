vim.cmd [[
  aunmenu PopUp.How-to\ disable\ mouse

  anoremenu PopUp.Definition  <cmd>lua vim.lsp.buf.definition()<cr>
  anoremenu PopUp.Back        <C-o>
  anoremenu PopUp.Forward     <C-i>
]]
