-- Options are automatically loaded before lazy.nvim startup
-- Add any additional options here
-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.g.maplocalleader = "\\"

-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

-- opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
-- opt.spelllang = { "es" }
opt.spelllang = { "es_es" }
opt.spelllang = "es"
opt.spell = true
opt.splitbelow = true -- Put new windows below current
-- opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Disable line wrap
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- if vim.fn.has("nvim-0.10") == 1 then
--   opt.smoothscroll = true
-- end

vim.opt.list = true
vim.cmd([[highlight SnacksIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight SnacksIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight SnacksIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight SnacksIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight SnacksIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight SnacksIndent6 guifg=#C678DD gui=nocombine]])

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    vim.opt.cmdheight = 1
  end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    vim.opt.cmdheight = 0
  end,
})

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldmethod = "manual"

-- Fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0

-- vim.notify = require("notify")

vim.cmd([[
"" Remember cursor position
augroup vimrc-remember-cursor-position
autocmd!
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

]])

-- vim.g.grammarous_jar_url = "https://www.languagetool.org/download/LanguageTool-5.9.zip"
-- vim.cmd([[
-- " let g:grammarous#jar_url = 'https://www.languagetool.org/download/LanguageTool-5.9.zip'
-- " let g:languagetool_jar="/usr/share/java/languagetool/languagetool-commandline.jar"
-- " let g:languagetool_server_jar="/usr/share/java/languagetool/languagetool-commandline.jar"
-- " let g:vimwiki_global_ext = 0
-- " let g:vimwiki_table_mappings = 1
-- " let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
-- "
-- " :hi VimwikiHeader1 guifg=#FF79C6
-- " :hi VimwikiHeader2 guifg=#50FA7B
-- " :hi VimwikiHeader3 guifg=#BD93F9
-- " :hi VimwikiHeader4 guifg=#F1FA8C
-- " :hi VimwikiHeader5 guifg=#A3F7FF
-- " :hi VimwikiHeader6 guifg=#434758
-- "
-- " ]])

vim.cmd([[
map <leader>z :!zathura <c-r>%<backspace><backspace><backspace>pdf &<CR><CR>
map <F5> :w! \| !compiler <c-r>%<CR>
autocmd FileType tex map <leader>a :VimtexCompile<CR>

nnoremap <F9> "=strftime("%c")<CR>P
inoremap <F9> <C-R>=strftime("%c")<CR>
]])

vim.cmd([[
map <F6> :setlocal spell! spelllang=es_mx<CR>
set spelllang=es,cjk
]])

vim.cmd([[
" hi link texStatement texCmd
" let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
" let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
" " let g:tex_conceal="abdmg"
" autocmd BufRead,BufNewFile *.tex set filetype=tex
" autocmd BufNewFile,BufRead *.tex set syntax=tex
" autocmd BufNewFile,BufRead *.cls set syntax=tex
let g:livepreview_previewer = 'zathura'
let g:vimtex_indent_lists = []
" let b:did_indent = 1
]])
-- vim.g["tex_indent_items"] = 0 -- turn off enumerate indent
--
--

vim.g.lazyvim_picker = "snacks"
