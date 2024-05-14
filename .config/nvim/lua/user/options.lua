vim.opt.backup = false                            -- creates a backup file
vim.opt.clipboard =
"unnamedplus"                                     -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                             -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menu,menuone,noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                          -- so that `` is visible in markdown files
vim.opt.fileencoding =
"utf-8"                                           -- the encoding written to a file
vim.opt.hlsearch = true                           -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                         -- ignore case in search patterns
vim.opt.mouse =
"a"                                               -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                            -- pop up menu height
vim.opt.showmode = false                          -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                           -- always show tabs
vim.o.smartcase = true                            -- smart case
vim.opt.smartindent = true                        -- make indenting smarter again
vim.opt.splitbelow = true                         -- force all horizontal splits to go below current window
vim.opt.splitright = true                         -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                          -- creates a swapfile
vim.opt.termguicolors = true                      -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300                          -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                           -- enable persistent undo
vim.opt.updatetime = 300                          -- faster completion (4000ms default)
vim.opt.writebackup = false                       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                          -- convert tabs to spaces
vim.opt.shiftwidth = 2                            -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                               -- insert 2 spaces for a tab
vim.opt.cursorline = true                         -- highlight the current line
vim.opt.number = true                             -- set numbered lines
vim.opt.relativenumber = true                     -- set relative numbered lines
vim.opt.numberwidth = 4                           -- set number column width to 2 {default 4}
vim.opt.textwidth = 0
vim.opt.signcolumn =
"yes"              -- always show the sign column, otherwise it would shift the text each time
vim.wo.wrap = true -- display lines as one long line
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.scrolloff = 999 -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "SauceCodePro NF:h11"
-- "mononoki Nerd Font Mono:h12 " -- the font used in graphical neovim applications
vim.opt.wildignore =
"*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*.tmp,*.toc,*.aux,*.log,*.bbl,*.blg,*.log,*.lof,*.lot,*.ilg,*.out,*.glo,*.gls,*.nlo,*.nls,*.brf,*.ist,*.glg,*.synctex.gz,*.tgz,*.idx,*.ind,*blx.bib,*.fdb_latexmk,*.run.xml,*.bcf,*.glsdefs,*.fls,*.eps,*.pdf,*.png,*.jpg" -- Show only files editable by vim
vim.opt.shortmess:append("c")
vim.o.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal,localoptions"
vim.g.mapleader = "<Space>"

-- Spell check settings
vim.opt.spelllang = "en_gb"
vim.o.spelloptions = "camel"
vim.g.tex_comment_nospell = 1
-- nvim-tree specific setting
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.cmd runs vimscript in [[ ]]
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions+=tcq]])

vim.o.magic = true

-- ufo folding
-- vim.o.foldcolumn = '1' -- '0' is not bad
-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldlevelstart = 99
-- vim.o.foldenable = true
--
-- Copilot settings
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
-- vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- treesitter settings
vim.g.skip_ts_context_commentstring_module = true
-- Motion settings
vim.api.nvim_set_keymap('i', '<M-j>', '<Right>', { noremap = true, silent = true })
-- save folds automatically
vim.cmd([[
if exists("g:loaded_restore_view")
    finish
endif
let g:loaded_restore_view = 1

if !exists("g:skipview_files")
    let g:skipview_files = []
endif

function! MakeViewCheck()
    if &l:diff | return 0 | endif
    if &buftype != '' | return 0 | endif
    if expand('%') =~ '\[.*\]' | return 0 | endif
    if empty(glob(expand('%:p'))) | return 0 | endif
    if &modifiable == 0 | return 0 | endif
    if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
    if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif

    let file_name = expand('%:p')
    for ifiles in g:skipview_files
        if file_name =~ ifiles
            return 0
        endif
    endfor

    return 1
endfunction

augroup AutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufWritePre,BufWinLeave ?* if MakeViewCheck() | silent! mkview | endif
    autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
augroup END
]])
