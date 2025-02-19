set nocompatible
set hidden
set noswapfile

set mouse=nvr
aunmenu PopUp.How-to\ disable\ mouse
aunmenu PopUp.-1-

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
let c_syntax_for_h = 1

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
let tinted_colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  colorscheme base16-tomorrow-night-eighties
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

" {{{ gitsigns
lua << EOF
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    do
      local function prev_hunk()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end
      local function next_hunk()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end
      map('n', '[c', prev_hunk, {expr=true})
      map('n', ']c', next_hunk, {expr=true})
    end

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
EOF
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

" {{{ gnupg

let g:GPGPreferSymmetric = 1
let g:GPGPreferArmor = 1

" }}}

" {{{ rg or ag
let &grepprg = 'rg --vimgrep'
let g:ackprg = 'rg --vimgrep --no-heading'
" }}}

" {{{ LSP

command A :ClangdSwitchSourceHeader

lua << EOF
local nvim_lsp = require('lspconfig')
local exp = vim.fn.expand

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
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
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

end

local common_flags = {
  debounce_text_changes = 150,
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
do
  local servers = {
    'pylsp',
    'ts_ls',
    'clangd',
    'blueprint_ls',
    'gopls',
    'rust_analyzer',
  }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = common_flags,
    }
  end
end

nvim_lsp['lua_ls'].setup {
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      telemetry = { enable = false },
    },
  },
  flags = common_flags,
  on_attach = on_attach,
}

nvim_lsp.csharp_ls.setup {
  cmd = { exp'~/.dotnet/tools/csharp-ls' },
  cmd_env = { DOTNET_ROOT = '/opt/dotnet-sdk-bin-7.0' },
  flags = common_flags,
  on_attach = on_attach,
}

do
  local opts = {
    server = {
      on_attach = on_attach,
    },
  }
  require('clangd_extensions').setup(opts)
end

EOF

" }}}

" {{{ DAP
lua << EOF
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-dap',
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

  ensure_installed = {
    'blueprint',
    'c',
    'c_sharp',
    'comment',
    'cpp',
    'devicetree',
    'dot',
    'git_config',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'html',
    'http',
    'java',
    'jq',
    'json',
    'kotlin',
    'linkerscript',
    'llvm',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'meson',
    'ninja',
    'python',
    'regex',
    'rst',
    'rust',
    'teal',
    'todotxt',
    'toml',
    'vim',
    'yaml',
  },

  -- Modules and its options go here
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = {
    enable = true,
    disable = {
      'rust',
      'python',
    },
  },
  textobjects = { enable = true },
}
EOF

" }}}

" {{{ Fidget
lua << EOF
require("fidget").setup {}
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

lua << EOF
require "telescope".setup {
  defaults = {
    path_display = {"filename_first"},
  },
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
}
EOF
" }}}

" {{{ JSX
let g:jsx_ext_required = 0
" }}}

" {{{ Markdown
let g:vim_markdown_folding_disabled = 1
autocmd FileType markdown setlocal conceallevel=2
" }}}

" {{{ clingo/gringo
autocmd FileType gringo setlocal commentstring=%%\ %s
" }}}

" {{{ vimwiki
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
      \ 'path': '~/Documents/vimwiki/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md',
      \}]
" }}}

set tags+=./tags,~/tags,~/.vim/tags

set exrc

" vim: foldmethod=marker foldmarker={{{,}}} :
