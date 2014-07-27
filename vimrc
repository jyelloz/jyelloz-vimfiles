set nocompatible
set hidden
set noswapfile

" {{{ snipMate options
let g:snips_author = "Jordan Yelloz"
let g:snippets_dir = $HOME . "/.vim/snippets"
" }}}

call pathogen#infect ()

syntax enable
filetype plugin indent on

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
inoremap <Nul> <C-o>
inoremap <C-@> <C-x><C-o>
" imap <C-Space> <C-x> <C-o>
" imap <C-S-Space> <C-p>
" imap <D-Space> <C-x> <C-o>
" imap <D-S-Space> <C-p>
"iunmap <C-x> <C-o>
"iunmap <C-p>
" }}}

" set modeline
set fileformats+=mac
set encoding=utf-8

set textwidth=79
set formatoptions=tcv
set cinoptions='(0,W4,m1'

" {{{ tab behavior
set sts=4
set tabstop=4
set shiftwidth=4
set expandtab
" }}}

" {{{ visual options
set ruler
set laststatus=2
set cursorline
set showcmd
set virtualedit=all
set bs=indent,eol,start
set linebreak

if has ("gui_macvim")
    set guifont=Terminus:h20
    set noantialias
    set fuoptions=maxhorz,maxvert
    set number
elseif has ("gui_running")
    set number
    "set guifont=Monospace\ 12
    set guifont=Terminus\ 12
    set showbreak=""
else
    " set showbreak=\>\ 
endif

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark
let g:molokai_original = 0
colorscheme molokai

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

" {{{ bitbake commands
augroup bitbake
    autocmd BufRead,BufNewFile *.bb setlocal filetype=bitbake
    autocmd BufRead,BufNewFile *.bbclass setlocal filetype=bitbake
augroup END
" }}}

" {{{ vala commands
augroup vala
    autocmd BufRead,BufNewFile *.vala setlocal filetype=vala
    autocmd BufRead,BufNewFile *.vapi setlocal filetype=vala nomodifiable readonly noswapfile
    autocmd BufEnter,FileType *.vala setlocal efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
    autocmd BufEnter,FileType *.vapi setlocal efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
augroup END
" }}}

" {{{ git
autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"
" }}}

" {{{ Taglist options
" let Tlist_File_Fold_Auto_Close = 1
" let Tlist_Ctags_Cmd = 'anjuta-tags'
" let tlist_vala_settings='c#;g:enum;s:struct;i:interface;c:class;m:method'
" }}}

" {{{ tagbar options
nnoremap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'anjuta-tags'
let g:tagbar_left = 1
let g:tagbar_autoshowtag = 1
" }}}

" {{{ NERDCommenter
let NERDSpaceDelims       = 1
let NERDRemoveExtraSpaces = 1
" }}}

" {{{ NERDTree

nnoremap <silent> <F2> :silent NERDTreeToggle<CR>
nnoremap <silent> <F3> :silent NERDTreeFind<CR>

let NERDTreeIgnore=['\.pyc$', '\.o$']


" }}}

" {{{ syntax adjustments
"Use the C syntax for varnish source files.
autocmd BufRead,BufNewFile *.vcl setlocal filetype=vcl
autocmd! Syntax vcl source $VIMRUNTIME/syntax/c.vim
"Use the JavaScript syntax for JSON data.
autocmd BufRead,BufNewFile *.json setlocal filetype=json
autocmd! Syntax json source $VIMRUNTIME/syntax/yaml.vim

" special python files
autocmd BufRead,BufNewFile fabfile setlocal filetype=python
autocmd BufRead,BufNewFile *.tac setlocal filetype=python
autocmd BufRead,BufNewFile wscript* setlocal filetype=python

autocmd BufRead,BufNewFile /boot/grub*/grub.conf setlocal fileencoding=latin1
autocmd BufRead,BufNewFile *-bugreport.txt setlocal filetype=gdb

autocmd BufRead,BufNewFile *.less setfiletype less

" }}}

" {{{ syntaxcomplete
" if has ("autocmd") && exists ("+omnifunc")
    " autocmd Filetype *
                " \   if &omnifunc == "" |
                " \       setlocal omnifunc=syntaxcomplete#Complete |
                " \   endif
    " autocmd FileType python set omnifunc=pythoncomplete#Complete
    " autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    " autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    " autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" endif
    autocmd Syntax handlebars setlocal indentexpr=HtmlIndent() foldmarker=[[[,]]]
" }}}

" {{{ python-mode
" let g:pymode = 1
let g:pymode_folding = 0
let g:pymode_signs = 0
let g:pymode_motion = 0
let g:pymode_rope = 0
let g:pymode_run = 0
let g:pymode_lint_write = 0
let g:pymode_lint_signs = 0
let g:pymode_lint_checker = 'pep8'
let g:pymode_lint_ignore = "E221,C0110,C0111,C0103,W0142,W0702,E1101,R0903,R0901,W061,R0201"
let g:pymode_lint_signs_always_visible = "1"

let g:pymode_rope_autocomplete_map = ""
let g:pymode_run_key = ""
let g:pymode_doc_key = ""
let g:pymode_breakpoint_key = ""

" }}}

" {{{ jedi-vim
" let g:jedi#auto_initialization = 0
let g:jedi#use_tabs_not_buffers = 0
" }}}

" {{{ ropevim

let ropevim_enable_shortcuts  = 0
let ropevim_vim_completion    = 0
let ropevim_extended_complete = 1
let ropevim_guess_project     = 1
let ropevim_goto_def_newwin   = 1
" nmap <silent> <leader>gd :RopeGotoDefinition<CR>

" }}}

" {{{ clang_complete

let g:clang_library_path = '/usr/lib64'
let g:clang_use_library  = 1

" }}}

" {{{ ctrlp

let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|\.pyc$'

" }}}

" {{{ powerline
let g:Powerline_symbols = 'unicode'
" }}}

" {{{ airline
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_linecolumn_prefix = '␊ '
  let g:airline_linecolumn_prefix = '␤ '
  let g:airline_linecolumn_prefix = '¶ '
  " let g:airline#extensions#branch#symbol = '⎇ '
  let g:airline#extensions#branch#symbol = ''
  let g:airline#extensions#paste#symbol = 'ρ'
  let g:airline#extensions#paste#symbol = 'Þ'
  let g:airline#extensions#paste#symbol = '∥'
  let g:airline#extensions#whitespace#symbol = 'Ξ'

  let g:airline_theme = 'simple'

" }}}

set tags+=./tags,~/tags,~/.vim/tags

set exrc

" vim: foldmethod=marker foldmarker={{{,}}} :
