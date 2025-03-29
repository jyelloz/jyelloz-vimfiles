vim.cmd.command('A', ':ClangdSwitchSourceHeader')

local nvim_lsp = require'lspconfig'
local exp = vim.fn.expand

local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }

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

nvim_lsp.lua_ls.setup {
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
  require'clangd_extensions'.setup(opts)
end
