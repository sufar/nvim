-- whick-key bind.
local status_ok, which_key = pcall(require, "which-key")
if status_ok then
  local f_nopts = {
    mode = "n",
    prefix = "f",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  }

  local f_nmappings = {
    ["d"] = { "<cmd>RustDebuggables<CR>", "RustDebuggables" },
    ["r"] = { "<cmd>RustRunnables<CR>", "RustRunnables" },
    ["a"] = { "<cmd>RustHoverActions<cr>", "RustHoverActions" },
    ["k"] = { "<cmd>RustMoveItemUp<cr>", "RustMoveItemUp" },
    ["j"] = { "<cmd>RustMoveItemDown<cr>", "RustMoveItemDown" },
    ["s"] = { "<cmd>RustSetInlayHints<cr>", "RustSetInlayHints" },
    ["S"] = { "<cmd>RustUnsetInlayHints<cr>", "RustUnsetInlayHints" },
    ["i"] = { "<cmd>RustEnableInlayHints<cr>", "RustEnableInlayHints" },
    ["I"] = { "<cmd>RustDisableInlayHints<cr>", "RustDisableInlayHints" },
    ["m"] = { "<cmd>RustExpandMacro<cr>", "RustExpandMacro" },
    ["c"] = { "<cmd>RustOpenCargo<cr>", "RustOpenCargo" },
    ["p"] = { "<cmd>RustParentModule<cr>", "RustParentModule" },
    ["l"] = { "<cmd>RustJoinLines<cr>", "RustJoinLines" },
  }

  local vopts = {
      mode = "v",
      prefix = "f",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local vmappings = {
      ["r"] = { "<Cmd>RustHoverRange<CR>", "RustHoverRange" },
    }

  which_key.register(vmappings, vopts)
  which_key.register(f_nmappings, f_nopts)
end
