return {
  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  {
    'echasnovski/mini.surround',
    event = 'verylazy',
    opts = {
      n_lines = 500,
    },
  },
}
