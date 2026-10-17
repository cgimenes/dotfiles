return {
  cmd = { 'hledger-lsp' },
  filetypes = { 'hledger', 'journal' },
  root_markers = { '.git', '*.journal' },
  single_file_support = true,
  settings = {
    hledger = {
      formatting = {
        amountAlignmentMode = 'decimal',
        amountAlignmentColumn = 59,
      },
      diagnostics = {
        accountCheck = 'strict',
      },
    },
  },
}
