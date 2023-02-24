local mason_home = vim.fn.stdpath "data" .. "/mason"
local config = {
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
      mason_home .. "/packages/codelldb/extension/adapter/codelldb",
      mason_home .. "/packages/codelldb/extension/lldb/lib/liblldb.so")
  },
  server = {
    on_attach = function(_, bufnr)
      -- whick-key bind.
      local status_ok, which_key = pcall(require, "which-key")
      if status_ok then
        local f_nopts = {
          mode = "n",
          prefix = "f",
          buffer = bufnr,
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
          buffer = bufnr,
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
    end,
  },
}

return config
