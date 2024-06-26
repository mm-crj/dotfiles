require('user.plugins')
require('impatient') -- Improves Startup Performance

require('user.options')
require('user.keymaps')
require('user.commands')

-- require('user.treesitter')
require('ts_context_commentstring').setup {}
require('user.lsp') -- lsp including cmp, snippets etc.
require('user.vimtex')

require('user.whichkey') -- keymaps
-- require('user.copilot')  -- copilot

require('user.dap') -- debugger

require('user.autopairs')
require('user.comment')
require('user.gitsigns')
require('user.nvim-tree') -- file explorer
require('user.alpha')     -- home screen
require('user.autosave')
require('user.remember')  -- remembers last cursor position
-- require('user.ufo')       -- folds
require('user.auto-session')
require('project_nvim').setup()
-- require('user.ltex-ls')
--[[ require('leap').add_default_mappings() ]]
--[[ require('flit').setup() ]]
--[[ require('julia-vim') ]]
--[[ require('JuliaFormatter.vim') ]]
-- UI
require('user.bufferline')
require('user.indentline')
require('user.lualine')

require('neoscroll').setup() -- smooth scrolling

-- telescope
require('user.telescope')
require('telescope').load_extension('luasnip')
require('telescope').load_extension('projects')
require('telescope').load_extension('diff')

-- colorscheme (keep last to over-ride default colors)
require('hlargs').setup()
require('colorizer').setup()
require('user.onedark')
