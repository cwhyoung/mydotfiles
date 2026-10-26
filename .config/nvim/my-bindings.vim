"Set the leader key for key bindings using the space bar
"let mapleader=" "
nmap <C-n> :NERDTreeToggle<CR>

map <leader>d :ColorizerAttachToBuffer<CR>
map <leader>D: ColorizerDetachFromBuffer

" Shortcutting split navigation, saving a keypress:
"	map <C-h> <C-w>h
"	map <C-j> <C-w>j
"	map <C-k> <C-w>k
"	map <C-l> <C-w>l

"Set the Clipboard to the System Clipboard
set clipboard+=unnamedplus

"Veritcially centre screen when going into insert mode
autocmd InsertEnter * norm zz

"Remove trailing white space on save
autocmd BufWritePre * %s/\s\+$//e

"TMUX Navigator
"M.general = {i
" n = {
"    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
"    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
"    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
"    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
" }
"}

nnoremap <silent> <C-h> <Cmd>NvimTmuxNavigateLeft<CR>
nnoremap <silent> <C-j> <Cmd>NvimTmuxNavigateDown<CR>
nnoremap <silent> <C-k> <Cmd>NvimTmuxNavigateUp<CR>
nnoremap <silent> <C-l> <Cmd>NvimTmuxNavigateRight<CR>
nnoremap <silent> <C-\> <Cmd>NvimTmuxNavigateLastActive<CR>
nnoremap <silent> <C-Space> <Cmd>NvimTmuxNavigateNext<CR>

"Set mouse scrolling
set mouse=a

set termguicolors
set cursorline
set cursorcolumn
highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#2b2b2b

"Vim Command line AutoComplete
set wildmode=longest,list,full
