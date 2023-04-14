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
      name = "Markdown",
      p = { "<cmd>Glow<cr>", "Markdown Preview" },
      c = { "<cmd>Glow!<cr>", "Close Preview" },
    }
  }

  which_key.register(mappings, opts)
end
