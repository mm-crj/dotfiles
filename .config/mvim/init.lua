-- Neovim Configuration
require 'user.options'
require 'user.keymaps'
require 'user.autocommands'
require 'user.lspconfig'
-- require 'user.quickfix'

-- Colorscheme
vim.opt.termguicolors = true
vim.cmd [[colorscheme slate]] -- habamax, sorbet

-- vim.lsp.set_log_level("debug")
--vim.lsp.diagnostic.set_loclist()
