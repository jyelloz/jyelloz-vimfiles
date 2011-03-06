set nocompatible
set hidden

" {{{ snipMate options
let g:snips_author = "Jordan Yelloz"
" }}}

call pathogen#runtime_append_all_bundles ("vimpyre")
call pathogen#helptags ()

" {{{ key bindings
let mapleader = ","

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" nnoremap <silent> <F3> :silent NERDTreeClose<CR>:TlistToggle<CR>
" nnoremap <silent> <F2> :silent TlistClose<CR>:NERDTreeToggle<CR>

" easier up-down behavior
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" tab buffer switching
nmap <silent> <tab> :silent bn<cr>
nmap <silent> <S-tab> :silent bp<cr>

" control-space completion
imap <Nul> <C-n>
imap <C-Space> <C-n>
imap <C-S-Space> <C-p>
"iunmap <C-n>
"iunmap <C-p>

" }}}

syntax enable
filetype plugin indent on

set modeline
set fileformats+=mac
set encoding=utf-8

" {{{ tab behavior
set sts=4
set tabstop=4
set shiftwidth=4
set expandtab
" }}}

" {{{ visual options
set ruler
set laststatus=2
set showcmd
set virtualedit=all
set bs=indent,eol,start
set linebreak

if has ("gui_macvim")
    set guifont=Terminus:h20
    set noantialias
    set fuoptions=maxhorz,maxvert
elseif has ("gui_running")
    set number
    "set guifont=Monospace\ 12
    set guifont=Terminus\ 12
    set showbreak=""
else
    " set showbreak=\>\ 
endif

set background=dark

set showmatch
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

set wildmode=list:longest
set wildignore=*.swp,*.bak.*.pyc,*.class,*.o
set wildmenu
" }}}

" {{{ search options
set incsearch
set nohlsearch
set hlsearch
set ignorecase
set smartcase
" }}}

" {{{ vala commands
augroup vala
    autocmd BufRead,BufNewFile *.vala set filetype=vala
    autocmd BufRead,BufNewFile *.vapi set filetype=vala
    autocmd BufEnter,FileType *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
    autocmd BufEnter,FileType *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
augroup END
" }}}

" {{{ Taglist options
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Ctags_Cmd = 'anjuta-tags'
let tlist_vala_settings='c#;g:enum;s:struct;i:interface;c:class;m:method'
" }}}

" {{{ NERDCommenter
let NERDSpaceDelims       = 1
let NERDRemoveExtraSpaces = 1
" }}}

" {{{ syntax adjustments
"Use the C syntax for varnish source files.
autocmd BufRead,BufNewFile *.vcl set filetype=vcl
autocmd! Syntax vcl source $VIMRUNTIME/syntax/c.vim
"Use the JavaScript syntax for JSON data.
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd! Syntax json source $VIMRUNTIME/syntax/yaml.vim
"Use the Python syntax for twisted configurations.
autocmd BufRead,BufNewFile *.tac set filetype=python
"autocmd BufRead,BufNewFile wscript set filetype=python
autocmd BufRead,BufNewFile wscript* set filetype=python
autocmd BufRead,BufNewFile /boot/grub/grub.conf set fileencoding=latin1
autocmd BufRead,BufNewFile *-bugreport.txt set filetype=gdb
" }}}

set tags+=./tags,~/tags,~/.vim/tags

set exrc

" vim: set foldmethod=marker foldmarker={{{,}}} :

