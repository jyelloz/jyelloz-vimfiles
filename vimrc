set nocompatible
set hidden
set noswapfile

set mouse=nvr

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
set number
set virtualedit=all
set bs=indent,eol,start
set linebreak

if has ("gui_running")
  let &guifont = 'IBM Plex Mono Light 12'
  set showbreak=""
endif

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
elseif strlen($VTE_VERSION) > 0
  set t_Co=256
endif

if !has("nvim")
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif
set termguicolors
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

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

" {{{ tagbar options
nnoremap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_position = 'right'
let g:tagbar_autoshowtag = 1
" }}}

" {{{ fern.vim
nnoremap <silent> <F3> :Fern . -reveal=% -drawer -toggle -stay<CR>
let g:fern#renderer = "nerdfont"
autocmd FileType fern setlocal nonumber
" }}}

" {{{ lightline
  let g:lightline = {
    \ 'active': {
    \   'left': [
    \     [ 'mode', 'paste' ],
    \     [ 'gitbranch', 'readonly', 'filename', 'modified' ],
    \   ],
    \ },
    \ 'component_function': {
    \   'filetype': 'DevIconsLightLineFiletype',
    \   'fileformat': 'DevIconsLightLineFileformat',
    \   'gitbranch': 'FugitiveHead',
    \ }
  \ }

  function! DevIconsLightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  endfunction

  function! DevIconsLightLineFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
  endfunction
" }}}

" {{{ buffet
let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
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

" {{{ fzf/skim
nmap <silent> <C-p> :Files<CR>
nmap <silent> ;     :Buffers<CR>
" }}}

" {{{ CoC
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

if exists("&tagfunc")
  set tagfunc=CocTagFunc
endif

" }}}

" {{{ JSX
let g:jsx_ext_required = 0
" }}}

" {{{ Markdown
let g:vim_markdown_folding_disabled = 1
autocmd FileType markdown setlocal conceallevel=2
" }}}

set tags+=./tags,~/tags,~/.vim/tags

set exrc

" vim: foldmethod=marker foldmarker={{{,}}} :
