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
    ["p"] = { "<cmd>Glow<cr>", "Markdown Preview" },
    ["c"] = { "<cmd>Glow!<cr>", "Close Preview" },
  }

  which_key.register(f_nmappings, f_nopts)
end
