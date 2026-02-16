vim.opt.shada = ''
vim.opt.compatible = false
vim.opt.hidden = true
vim.opt.swapfile = false

vim.opt.mouse = 'nvr'
pcall(vim.cmd.aunmenu, 'PopUp.How-to\\ disable\\ mouse')
pcall(vim.cmd.aunmenu, 'PopUp.-1-')

vim.g.mapleader = ','

-- edit/reload config
vim.keymap.set('n', '<leader>ev', ':e $MYVIMRC<CR>', { silent = true })
vim.keymap.set('n', '<leader>sv', ':so $MYVIMRC<CR>', { silent = true })

-- easier up-down behavior
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '<down>', 'gj')
vim.keymap.set('n', '<up>', 'gk')

-- tab buffer switching
vim.keymap.set('n', '<tab>', ':silent bn<cr>', { silent = true })
vim.keymap.set('n', '<S-tab>', ':silent bp<cr>', { silent = true })

vim.opt.fileformats:append 'mac'
vim.opt.textwidth = 79
vim.opt.formatoptions = 'tcv'
vim.opt.cinoptions = '(0,W4,m1'
vim.opt.joinspaces = true
vim.g.c_syntax_for_h = true

vim.opt.sts = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.cursorline = true
vim.opt.showcmd = true
vim.opt.number = true
vim.opt.virtualedit = 'all'
vim.opt.bs = { 'indent', 'eol', 'start' }
vim.opt.linebreak = true

do
  vim.g.tinted_colorspace = 256
  vim.opt.termguicolors = true
  local vimrc = vim.fn.expand '~/.vimrc_background'
  if vim.fn.filereadable(vimrc) == 1 then
    vim.cmd.source(vimrc)
  else
    vim.cmd.colorscheme 'base16-tomorrow-night-eighties'
  end
end

vim.showmatch = true
vim.cmd.highlight('WhitespaceEOL', 'ctermbg=red guibg=red')
vim.cmd.match('WhitespaceEOL', '/\\s\\+$/')

vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.netrw_banner = 0
vim.g.netrw_browsex_viewer = 'xdg-open'

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = { 'COMMIT_EDITMSG' },
  command = 'normal! gg',
})

vim.g.GPGPreferSymmetric = 1
vim.g.GPGPreferArmor = 1

require 'usermod.dap'
require 'usermod.devicons'
require 'usermod.fidget'
require 'usermod.gitsigns'
require 'usermod.lsp'
require 'usermod.lualine'
require 'usermod.telescope'
require 'usermod.treesitter'
require 'usermod.trouble'
