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
      name = "Sql",
      q = { "<Cmd>SqlsExecuteQuery<CR>", "Execute Query" },
      v = { "<Cmd>SqlsExecuteQueryVertical<CR>", "Execute Query Vertical" },
      d = { "<Cmd>SqlsShowDatabases<CR>", "Show Databases" },
      s = { "<Cmd>SqlsShowSchemas<CR>", "Show Schemas" },
      c = { "<Cmd>SqlsShowConnections<CR>", "Show Connections" },
      D = { "<Cmd>SqlsSwitchDatabase<CR>", "Switch Database" },
      C = { "<Cmd>SqlsSwitchConnection<CR>", "Switch Connection" },
    }
  }

  which_key.register(mappings, opts)
end
