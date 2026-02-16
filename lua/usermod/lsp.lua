vim.cmd.command('A', ':ClangdSwitchSourceHeader')

local exp = vim.fn.expand

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
    'jdtls',
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
  require('clangd_extensions').setup()
end
