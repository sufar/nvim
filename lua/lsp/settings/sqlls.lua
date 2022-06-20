local opts = {}

opts.config = {
  settings = {
    connections = {
      {
        name = "mysql_local",
        adapter = "mysql",
        host = "localhost",
        port = 3306,
        user = "root",
        password = "zugle",
        database = "zugle",
      }
    }
  }
}
opts.on_attach = function (_, _)
end

return opts
