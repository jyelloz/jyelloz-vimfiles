set nocompatible
set hidden
set noswapfile

" {{{ snipMate options
let g:snips_author = "Jordan Yelloz"
let g:snippets_dir = $HOME . "/.vim/snippets"
" }}}

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

" }}}

" set modeline
set fileformats+=mac
set encoding=utf-8

set textwidth=79
set formatoptions=tcv
set joinspaces
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
let g:tagbar_ctags_bin = 'ctags'
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

" {{{ airline

  let g:airline_powerline_fonts = 1
  let g:airline_theme = 'powerlineish'
  let g:airline#extensions#tabline#enabled = 1

" }}}

" {{{ gnupg

let g:GPGPreferSymmetric = 1
let g:GPGPreferArmor = 1

" }}}

" {{{ rg or ag
if executable('rg')
  let &grepprg = 'rg --vimgrep'
  let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ag')
  " Use ag over grep
  let &grepprg = 'ag --nogroup --nocolor'
  let g:ackprg = 'ag --nogroup --nocolor --column'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" }}}

" {{{ ncm2/lsp

let g:ncm2#auto_popup = 0
let g:lsp_signs_enabled = 0

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rls']},
        \ 'whitelist': ['rust'],
        \ })
    au FileType rust call ncm2#enable_for_buffer()
    au FileType rust imap <buffer> <C-X><C-O> <Plug>(ncm2_manual_trigger)
endif

if executable('clangd')
   au User lsp_setup call lsp#register_server({
       \ 'name': 'clangd',
       \ 'cmd': {server_info->['clangd', "-compile-commands-dir=."]},
       \ 'whitelist': ['c', 'cpp'],
       \ })
   au FileType c,cpp call ncm2#enable_for_buffer()
   au FileType c,cpp imap <buffer> <C-X><C-O> <Plug>(ncm2_manual_trigger)
endif

if executable('pyls')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'pyls',
				\ 'cmd': {server_info->['pyls']},
				\ 'whitelist': ['python'],
				\ })
  au FileType python call ncm2#enable_for_buffer()
  au FileType python imap <buffer> <C-X><C-O> <Plug>(ncm2_manual_trigger)
endif

if executable('lua-lsp')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'lua-lsp',
				\ 'cmd': {server_info->['lua-lsp']},
				\ 'whitelist': ['lua'],
				\ })
  au FileType lua call ncm2#enable_for_buffer()
  au FileType lua imap <buffer> <C-X><C-O> <Plug>(ncm2_manual_trigger)
endif

" }}}

" {{{ JSX
let g:jsx_ext_required = 0
" }}}

set tags+=./tags,~/tags,~/.vim/tags

set exrc

" vim: foldmethod=marker foldmarker={{{,}}} :
