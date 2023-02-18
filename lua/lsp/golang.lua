local go, ok = require("go")
if not ok then
  return
end

go.setup({
  fillstruct = 'gopls',
  dap_debug = true,
  dap_debug_gui = true,
  lsp_cfg = true,
  icons = false,
  dap_debug_keymap = false,
  lsp_keymaps = false,
})

--[[ require('dap-go').setup() ]]
