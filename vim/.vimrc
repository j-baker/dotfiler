runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
set background=light
colorscheme solarized

filetype plugin indent on
set backspace=indent,eol,start
set ruler

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

au BufRead,BufNewFile *.ml,*.mli compiler ocaml

set number

au FileType ocaml call FT_ocaml()
function FT_ocaml()
	set textwidth=80
	set colorcolumn=80
	set shiftwidth=2
	set tabstop=2
	" ocp-indent with ocp-indent-vim
	let opamshare=system("opam config var share | tr -d '\n'")
	execute "autocmd FileType ocaml source".opamshare."/vim/syntax/ocp-indent.vim"
	filetype indent on
	filetype plugin indent on
endfunction

set rtp+=~/Repositories/ocp-indent-vim

function! OCamlType()
	let col = col('.')
	let line = line('.')
	let file = expand("%:p:r")
	echo system("annot -n -type ".line." ".col." ".file.".annot")
endfunction

map ,t :call OCamlType()<return>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
