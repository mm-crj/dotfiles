vim.o.number=true
vim.o.relativenumber=true
vim.o.compatible=false
-- Define the options table
local opts = { noremap = true, silent = true }

-- Set the key mapping
vim.api.nvim_set_keymap("n", "//", ":noh<CR>", opts)



