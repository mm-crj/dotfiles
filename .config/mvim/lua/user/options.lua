vim.opt.clipboard ="unnamedplus"          -- allows neovim to access the system clipboard
vim.o.number = true                    	  -- set line numbers
vim.o.relativenumber = true               -- set relative numbered lines
vim.o.smarttab = true
vim.o.splitbelow =true
local keymap = vim.api.nvim_set_keymap

keymap("n", "//", ":noh<CR>", opts)	 -- Clear search results with 
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]] -- autoformat on save

