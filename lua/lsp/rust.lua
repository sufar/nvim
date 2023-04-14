local mason_home = vim.fn.stdpath "data" .. "/mason"
local config = {
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      mason_home .. "/packages/codelldb/extension/adapter/codelldb",
      mason_home .. "/packages/codelldb/extension/lldb/lib/liblldb.so")
  },
  server = {
    on_attach = function(_, bufnr)
    end,
  },
}

return config
