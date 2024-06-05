return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { "gw", mode = { "n", "x", "o" }, function()
        require("flash").jump({
          pattern = ".", -- initialize pattern with any char
          search = {
            mode = function(pattern)
              -- remove leading dot
              if pattern:sub(1, 1) == "." then
                pattern = pattern:sub(2)
              end
              -- return word pattern and proper skip pattern
              return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
            end,
          },
        })
      end, desc = "Flash Word" },
      { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },
}
