require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,
  ["jdtls"] = function()
  end,
  ["sqls"] = function()
    require('lspconfig').sqls.setup {
      on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
      end
    }
  end,
}
