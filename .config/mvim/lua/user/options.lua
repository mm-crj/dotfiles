-- Set options
vim.opt.compatible = false
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.number = true             -- set line numbers
vim.opt.relativenumber = true     -- set relative numbered lines
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.background = "dark"
vim.opt.wrap = true
vim.opt.laststatus = 2
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.hidden = true

-- Syntax and filetype settings
vim.opt.syntax = "on"
vim.opt.filetype = "on"
vim.opt.filetype.plugin = "on"
vim.opt.filetype.indent = "on"

vim.opt.scrolloff = 999 -- Set scrolloff to 999
-- setglobal so =999
--
-- Auto-pair quotes
vim.api.nvim_set_keymap('i', "'", "'<C-o>'i", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '"', '""<C-o>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '$', '$$<C-o>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '(', '()<C-o>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '{', '{}<C-o>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '[', '[]<C-o>i', { noremap = true, silent = true })
-- short vim buffer file paths
vim.opt.shortmess:append("f")
