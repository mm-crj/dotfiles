-- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- let g:copilot_no_tab_map = v:true
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
