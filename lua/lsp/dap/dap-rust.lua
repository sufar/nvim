local opts = {}

local home = os.getenv("HOME")

-- Update this path
local extension_path = home .. '/.config/nvim/resources/rust/vscode-lldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

opts.dap = {
  adapter = require('rust-tools.dap').get_codelldb_adapter(
  codelldb_path, liblldb_path)
}

return opts
