local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local mappings = {
  d = { "<cmd>RustDebuggables<CR>", "RustDebuggables" },
  r = { "<cmd>RustRunnables<CR>", "RustRunnables" },
  a = { "<cmd>RustHoverActions<cr>", "RustHoverActions" },
  k = { "<cmd>RustMoveItemUp<cr>", "RustMoveItemUp" },
  j = { "<cmd>RustMoveItemDown<cr>", "RustMoveItemDown" },
  s = { "<cmd>RustSetInlayHints<cr>", "RustSetInlayHints" },
  S = { "<cmd>RustUnsetInlayHints<cr>", "RustUnsetInlayHints" },
  t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
  i = { "<cmd>RustEnableInlayHints<cr>", "RustEnableInlayHints" },
  I = { "<cmd>RustDisableInlayHints<cr>", "RustDisableInlayHints" },
  m = { "<cmd>RustExpandMacro<cr>", "RustExpandMacro" },
  c = { "<cmd>RustOpenCargo<cr>", "RustOpenCargo" },
  D = { "<cmd>RustOpenExternalDocs<Cr>", "Open Docs" },
  p = { "<cmd>RustParentModule<cr>", "Parent Module" },
  l = { "<cmd>RustJoinLines<cr>", "RustJoinLines" },
  v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
  R = {
    "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
    "Reload Workspace",
  },
}

local vopts = {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local vmappings = {
  r = { "<Cmd>RustHoverRange<CR>", "RustHoverRange" },
}
which_key.register(vmappings, vopts)
which_key.register(mappings, opts)
