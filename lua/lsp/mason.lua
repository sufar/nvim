require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,
  ["jdtls"] = function()
    vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java" },
    callback = function()
      local java_config = require("lsp.java")
      require('jdtls').start_or_attach(java_config)
      end,
      group = vim.api.nvim_create_augroup("jdtls", { clear = true })
    })
  end,
  ["sqls"] = function()
    require('lspconfig').sqls.setup {
      on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
      end
    }
  end,
}
