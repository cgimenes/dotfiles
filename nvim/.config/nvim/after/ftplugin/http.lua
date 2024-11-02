vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<CR>",
  "<cmd>lua require('kulala').run()<cr>",
  { noremap = true, silent = true, desc = "Execute the request" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "[",
  "<cmd>lua require('kulala').jump_prev()<cr>",
  { noremap = true, silent = true, desc = "Jump to the previous request" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "]",
  "<cmd>lua require('kulala').jump_next()<cr>",
  { noremap = true, silent = true, desc = "Jump to the next request" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>Ri",
  "<cmd>lua require('kulala').inspect()<cr>",
  { noremap = true, silent = true, desc = "[I]nspect the current request" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>Rc",
  "<cmd>lua require('kulala').copy()<cr>",
  { noremap = true, silent = true, desc = "[C]opy the current request as a curl command" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>Rp",
  "<cmd>lua require('kulala').from_curl()<cr>",
  { noremap = true, silent = true, desc = "[P]aste curl from clipboard as http request" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>Ra",
  "<cmd>lua require('kulala').run_all()<cr>",
  { noremap = true, silent = true, desc = "Run [A]ll requests" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>Rq",
  "<cmd>lua require('kulala').close()<cr>",
  { noremap = true, silent = true, desc = "[Q]uit" }
)
