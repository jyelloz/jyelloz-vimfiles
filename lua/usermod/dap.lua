local dap = require'dap'

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-dap',
  name = 'lldb'
}
local cconf = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
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

local dapui = require'dapui'
dapui.setup{}
local dapvirtual = require'nvim-dap-virtual-text'
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
