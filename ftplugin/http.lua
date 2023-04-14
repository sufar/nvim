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
      name = "Http",
      r = { "<CMD>lua require('rest-nvim').run()<CR>", "run the request under the cursor" },
      p = { "<CMD>lua require('rest-nvim').run(true)<CR>", "preview the request cURL command" },
      l = { "<CMD>lua require('rest-nvim').last()<CR>", "re-run the last request" },
    }
  }

  which_key.register(mappings, opts)
end
