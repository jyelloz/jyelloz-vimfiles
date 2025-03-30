local f = require 'telescope.builtin'
vim.keymap.set('n', '<leader>ff', f.find_files)
vim.keymap.set('n', '<leader>fg', f.live_grep)
vim.keymap.set('n', '<leader>fb', f.buffers)
vim.keymap.set('n', '<leader>fh', f.help_tags)
vim.keymap.set('n', '<leader>fs', f.lsp_dynamic_workspace_symbols)
vim.keymap.set('n', '<leader>fd', f.diagnostics)
vim.keymap.set('n', '<leader>fr', f.lsp_references)
vim.keymap.set('n', '<leader>fm', f.man_pages)

require('telescope').setup {
  defaults = {
    path_display = { 'filename_first' },
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
}
