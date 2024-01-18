return {
  {
    'folke/which-key.nvim',
    config = function ()
      require('which-key').setup()

      require('which-key').register {
        ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ebug', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
        ['<leader>q'] = { name = 'Session', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
      }
    end
  }
}
