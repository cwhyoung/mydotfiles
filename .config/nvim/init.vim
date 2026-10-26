	if !exists('g:vscode')
		source ~/.config/nvim/basic-setting.vim
        source ~/.config/nvim/myplugins.vim
        source ~/.config/nvim/my-bindings.vim
	endif

" COC AutoComplete
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

"Save file if forgot to open with sudo
command W :execute ':silent w !doas tee % > /dev/null' | :edit!
