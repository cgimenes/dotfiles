return {
  {
    'saghen/blink.cmp',
    -- !Important! Make sure you're using the latest release of LuaSnip
    -- `main` does not work at the moment
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    version = '*',
    opts = {
      snippets = {
        preset = 'luasnip',
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'dadbod', 'lazydev' },
        providers = {
          -- dont show LuaLS require statements when lazydev has items
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', fallbacks = { 'lsp' } },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        },
      },
      signature = {
        enabled = true,
        window = { border = 'single' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
      },
      completion = {
        documentation = {
          auto_show = true,
          window = { border = 'single' },
        },
        menu = {
          draw = {
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
