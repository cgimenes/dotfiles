return {
  {
    'akinsho/bufferline.nvim',
    opts = {
      options = {
        close_command = function(bufnr) -- can be a string | function, see "Mouse actions"
          MiniBufremove.delete(bufnr)
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "Explorer",
            highlight = "PanelHeading",
            padding = 1,
          },
        },
      }
    },
  }
}
