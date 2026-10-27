call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'xiyaowong/transparent.nvim'
"Plug 'alexghergh/nvim-tmux-navigation'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

lua require'colorizer'.setup()
lua require("ibl").setup()
