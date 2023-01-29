-- whick-key bind.
local status_ok, which_key = pcall(require, "which-key")
local which_key_config = require("core.whichkey")
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
    -- java
    ["O"] = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
    ["c"] = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test Class" },
    ["m"] = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "Test Nearest Method" },
    ["v"] = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
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
    ["e"] = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
    ["m"] = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
  }

  which_key.register(f_nmappings, f_nopts)
  which_key.register(which_key_config.g_nmappings, which_key_config.g_nopts)
  which_key.register(vmappings, vopts)
end
