-- whick-key bind.
local status_ok, which_key = pcall(require, "which-key")
if status_ok then
  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  }

  local mappings = {
    C = {
      name = "Python",
      m = { "<Cmd>lua require('dap-python').test_method()<CR>", "Test Method" },
      c = { "<cmd>lua require('dap-python').test_class()<CR>", "Test Class" },
    }
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
    C = {
      name = "Python",
      s = { "<cmd>lua require('dap-python').debug_selection()<CR>", "Debug Selection" },
    }
  }

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end
