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
elseif strlen($VTE_VERSION) > 0
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

" {{{ lua.vim
"
let lua_version = 5
let lua_subversion = 1
let g:lua_complete_omni = 1

let g:syntastic_lua_checkers = ['luac', 'luacheck']
" let g:syntastic_lua_checkers = ['luac']
let g:syntastic_lua_luacheck_args = '--no-unused-args'

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
let g:pymode = 1
" let g:pymode_debug = 1
let g:pymode_folding = 0
let g:pymode_signs = 0
let g:pymode_motion = 0
let g:pymode_rope = 1
let g:pymode_run = 0
let g:pymode_lint_write = 0
let g:pymode_lint_signs = 0
let g:pymode_lint_checker = ['pep8', 'pylint']
" let g:pymode_lint_ignore = "E221,C0110,C0111,C0103,W0142,W0702,E1101,R0903,R0901,W061,R0201"
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

" this is disabled and vim-clang is used now
let g:clang_complete_loaded = 1
let g:clang_library_path = '/usr/lib64'
let g:clang_use_library  = 1

" }}}

" {{{ vim-clang

let g:clang_c_completeopt = 'menuone,preview'
let g:clang_auto = 0
let g:clang_check_syntax_auto = 1
let g:clang_include_sysheaders = 1

" }}}

" {{{ ctrlp

let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|\.pyc$'

" }}}

" {{{ powerline
let g:Powerline_symbols = 'unicode'
" }}}

" {{{ airline

  let g:airline_powerline_fonts = 1

" }}}

" {{{ gnupg

let g:GPGPreferSymmetric = 1
let g:GPGPreferArmor = 1

" }}}

" {{{ ag (silver-searcher)
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --nogroup --nocolor --column'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" }}}

set tags+=./tags,~/tags,~/.vim/tags

set exrc

" vim: foldmethod=marker foldmarker={{{,}}} :
