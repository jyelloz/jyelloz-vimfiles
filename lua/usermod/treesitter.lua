require('nvim-treesitter.configs').setup {
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
