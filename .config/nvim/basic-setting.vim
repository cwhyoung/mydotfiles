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


"Fix Splitting
set splitbelow splitright

set cursorline
set cursorcolumn

"Lightline ColourScheme
    let g:lightline = {
                \ 'colorscheme': 'one',
                \ }

"Transparency
    let g:neovide_transparency=0.9
    let g:dracula_colorterm = 0
"Set Fonts
"
"Vertically centre document when entering insert mode
autocmd InsertEnter * norm  zz
