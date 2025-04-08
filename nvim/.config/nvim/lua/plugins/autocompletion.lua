return {
  {
    'saghen/blink.cmp',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      { 'fang2hou/blink-copilot' },
    },
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      fuzzy = {
        max_typos = function()
          return 0
        end,
        use_frecency = false,
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'dadbod', 'lazydev', 'copilot' },
        providers = {
          -- dont show LuaLS require statements when lazydev has items
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', fallbacks = { 'lsp' } },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
          copilot = {
            name = 'Copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
      signature = {
        enabled = true,
        window = { border = 'single' },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = { border = 'single' },
        },
        menu = {
          border = 'none',
          draw = {
            treesitter = { 'lsp' },
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'source_name' },
            },
            components = {
              label_description = {
                width = { max = 120 },
              },
            },
          },
        },
      },
    },
  },
}
