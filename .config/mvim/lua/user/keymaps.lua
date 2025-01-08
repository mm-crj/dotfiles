-- Key mappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "  -- Set leader key
keymap("n", "<Esc>", ":noh<CR>", opts)          -- Clear search results
keymap("n", "<Leader>w", ":w<CR>", opts)     -- Write (save) buffer with leader w
keymap("n", "<Leader>e", ":Lexplore 25<CR>", opts)     -- open netrw
keymap("n", "<Leader>q", ":q<CR>", opts)     -- close window
-- Leader b
-- cycle through buffers with leader bb
keymap("n", "<Leader>bb", ":set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>", opts)
-- Format buffer with leader bf
keymap("n", "<Leader>bf", ":lua vim.lsp.buf.format()<CR>", opts)
-- delete buffer with leader bd
keymap("n", "<Leader>bd", ":bdelete<CR>", opts)  
