set nocompatible
set hidden
set noswapfile

set mouse=nvr

if !has("nvim")
  syntax enable
endif
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

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" }}}

" {{{ search options
set incsearch
set nohlsearch
set hlsearch
set ignorecase
set smartcase
" }}}

" {{{ netrw options
let g:netrw_banner = 0
let g:netrw_browsex_viewer = "xdg-open"
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
let &grepprg = 'rg --vimgrep'
let g:ackprg = 'rg --vimgrep --no-heading'
" }}}

" {{{ LSP

lua << EOF
-- local rust_tools = require'rust-tools'
--rust_tools.setup({})
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
do
  local servers = {
    'pyright',
    'tsserver',
    'clangd',
  }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
    }
  end
end

nvim_lsp['sumneko_lua'].setup {
  cmd = { '/home/joe/Projects/lua-language-server/lua-language-server' },
  on_attach = on_attach,
}

do
  local opts = {
    server = {
      on_attach = on_attach,
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            disabled = {
              -- For RTIC which generates non-standard variable names.
              'incorrect-ident-case',
              -- For RTIC which uses a macro that rust-analyzer can't find.
              'unresolved-proc-macro',
              'unresolved-macro-call',
            },
          },
        },
      },
    },
  }
  require('rust-tools').setup(opts)
end
EOF

" }}}

" {{{ DAP
lua << EOF
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode', -- adjust as needed
  name = "lldb"
}
local cconf = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}
dap.configurations.c = cconf
dap.configurations.cpp = cconf
dap.configurations.rust = cconf
EOF

lua << EOF
local dap = require('dap')
local dapui = require('dapui')
dapui.setup({})
local dapvirtual = require('nvim-dap-virtual-text')
dapvirtual.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end
EOF

" }}}

" {{{ tree-sitter

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- Modules and its options go here
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = {
    enable = true,
    disable = {"rust"},
  },
  textobjects = { enable = true },
}
EOF

" }}}

" {{{ Trouble
lua << EOF
require'nvim-web-devicons'.setup {
  default = true;
}
require("trouble").setup {
}
EOF
" }}}

" {{{ Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>fd <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <leader>fD <cmd>Telescope lsp_workspace_diagnostics<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
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
