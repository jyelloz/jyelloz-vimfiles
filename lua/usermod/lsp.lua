vim.cmd.command('A', ':ClangdSwitchSourceHeader')

local exp = vim.fn.expand

local on_attach = function(ev)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(ev.buf, ...)
  end

  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap(
    'n',
    '<C-k>',
    '<cmd>lua vim.lsp.buf.signature_help()<CR>',
    opts
  )
  buf_set_keymap(
    'n',
    '<space>wa',
    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
    opts
  )
  buf_set_keymap(
    'n',
    '<space>wr',
    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
    opts
  )
  buf_set_keymap(
    'n',
    '<space>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts
  )
  buf_set_keymap(
    'n',
    '<space>D',
    '<cmd>lua vim.lsp.buf.type_definition()<CR>',
    opts
  )
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap(
    'n',
    '<space>ca',
    '<cmd>lua vim.lsp.buf.code_action()<CR>',
    opts
  )
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap(
    'n',
    '<space>e',
    '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>',
    opts
  )
  buf_set_keymap(
    'n',
    '<space>q',
    '<cmd>lua vim.diagnostic.setloclist()<CR>',
    opts
  )
end

vim.api.nvim_create_autocmd('LspAttach', { callback = on_attach })

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('csharp_ls', {
  cmd = { exp '~/.dotnet/tools/csharp-ls' },
  cmd_env = { DOTNET_ROOT = '/opt/dotnet-sdk-bin-7.0' },
})

do
  local servers = {
    'blueprint_ls',
    'clangd',
    'csharp_ls',
    'gopls',
    'lua_ls',
    'rust_analyzer',
    'ts_ls',
    'ty',
  }
  for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
  end
end

do
  local opts = {
    server = {
      on_attach = on_attach,
    },
  }
  require('clangd_extensions').setup(opts)
end
