-- Auto commands (executes automatically)
local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  group = augroup,
  desc = "Use q to close the window",
  command = "nnoremap <buffer> q <cmd>quit<cr>",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup,
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})
-- remove trailing whitespaces on save

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   group = augroup,
--   desc = "Remove trailing whitespaces on save",
--   pattern = "*",
--   callback = function()
--     -- Save cursor position
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     -- Perform the substitution
--     vim.cmd([[%s/\s\+$//e]])
--     -- Restore cursor position
--     vim.api.nvim_win_set_cursor(0, cursor_pos)
--   end,
-- })
-- don't auto comment new line
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  desc = "don't auto comment new line",
  pattern = "*",
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

vim.cmd [[
   " Neovim Synctex setup (requires pip install neovim-remote)
  function! s:write_server_name() abort
    let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
    call writefile([v:servername], nvim_server_file)
  endfunction

  augroup vimtex_common
    autocmd!
    autocmd FileType tex call s:write_server_name()
  augroup END

  if empty(v:servername) && exists('*remote_startserver')
      call remote_startserver('VIM')
  endif
 ]]
vim.api.nvim_create_user_command('ExpandLatexMacros', function()
  -- Order matters: do longer/more specific macros first!

  -- Macros with arguments (do these first)
  vim.cmd([[%s/\\dx{\([^}]*\)}/\\mathrm{d}\1/ge]])

  -- Subscript macros (longer ones first to avoid partial matches)
  vim.cmd([[%s/\\epsnun\>/_{\\epsilon,\\nu,N}/ge]])
  vim.cmd([[%s/\\epsdelta\>/_{\\epsilon,\\delta}/ge]])
  vim.cmd([[%s/\\epsnu\>/_{\\epsilon,\\nu}/ge]])
  vim.cmd([[%s/\\nun\>/_{\\nu,N}/ge]])
  vim.cmd([[%s/\\oun\>/_{\0,N}/ge]])

  -- Superscript macros
  vim.cmd([[%s/\\i\>/^{(i)}/ge]])
  vim.cmd([[%s/\\1\>/^{(1)}/ge]])
  vim.cmd([[%s/\\2\>/^{(2)}/ge]])

  -- Mathbb macros
  vim.cmd([[%s/\\Rd\>/\\mathbb{R}^d/ge]])
  vim.cmd([[%s/\\R\>/\\mathbb{R}/ge]])

  -- PairedDelimiters
  vim.cmd([[%s/\\abs\*\?{\([^}]*\)}/\\lvert \1 \\rvert/ge]])
  vim.cmd([[%s/\\norm\*\?{\([^}]*\)}/\\lVert \1 \\rVert/ge]])

  print("LaTeX macros expanded!")
end, {})

-- user commands (needs to be manually executed)
vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", {})
