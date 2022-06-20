local opts = {}

opts.config = {
  settings = {
    sqls = {
      connections = {
        {
          driver = 'mysql',
          dataSourceName = 'root:zugle@tcp(127.0.0.1:3306)/ry-vue',
        },
      },
    },
  }
}

opts.on_attach = function(client, bufnr)
  require('sqls').on_attach(client, bufnr)

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
      ["q"] = { "<Cmd>SqlsExecuteQuery<CR>", "Execute Query" },
      ["v"] = { "<Cmd>SqlsExecuteQueryVertical<CR>", "Execute Query Vertical" },
      ["d"] = { "<Cmd>SqlsShowDatabases<CR>", "Show Databases" },
      ["s"] = { "<Cmd>SqlsShowSchemas<CR>", "Show Schemas" },
      ["c"] = { "<Cmd>SqlsShowConnections<CR>", "Show Connections" },
      ["D"] = { "<Cmd>SqlsSwitchDatabase<CR>", "Switch Database" },
      ["C"] = { "<Cmd>SqlsSwitchConnection<CR>", "Switch Connection" },
    }

    which_key.register(f_nmappings, f_nopts)
  end
end

return opts
