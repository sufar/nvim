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
    ["r"] = { "<CMD>lua require('rest-nvim').run()<CR>", "run the request under the cursor" },
    ["p"] = { "<CMD>lua require('rest-nvim').run(true)<CR>", "preview the request cURL command" },
    ["l"] = { "<CMD>lua require('rest-nvim').last()<CR>", "re-run the last request" },
  }

  local f_vopts = {
    mode = "v",
    prefix = "f",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  }

  local f_vmappings = {
    ["t"] = { "<cmd>lua require('dap-python').debug_selection()<CR>", "Debug Selection" },
  }

  which_key.register(f_nmappings, f_nopts)
  which_key.register(f_vmappings, f_vopts)
end
