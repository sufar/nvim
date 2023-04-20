local status_ok = require("core.utils").is_lsp_installed("gopls")
if not status_ok then
  return
end

require("go").setup({
  fillstruct = 'gopls',
  dap_debug = true,
  dap_debug_gui = false,
  lsp_cfg = true,
  icons = false,
  dap_debug_keymap = false,
  lsp_keymaps = false,
})
