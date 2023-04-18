local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.yamlls.setup {
  capabilities = capabilities,
  filetypes = { "yaml", "yaml.docker-compose" },
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}

local M = {}

M.setup = function ()

end

return M
