"set termguicolors
colorscheme dracula

"Editor Settings - Clipboard
set clipboard+=unnamedplus

set encoding=utf-8
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set number relativenumber
set termguicolors
set noswapfile
set nobackup
"syntax enable

"Fix Splitting
set splitbelow splitright

set cursorline
set cursorcolumn
highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#2b2b2b


"Lightline ColourScheme
    let g:lightline = {
                \ 'colorscheme': 'one',
                \ }

"Transparency
    let g:neovide_transparency=0.9
    let g:dracula_colorterm = 0

"Set Fonts

"Vertically centre document when entering insert mode
autocmd InsertEnter * norm  zz

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e

"Tab Completion wildmode
set wildmode=longest,list,full
