local lsp_installer = require('nvim-lsp-installer')
lsp_installer.setup({})

require "lsp.config".setup()

require "lsp.tools"
require "lsp.flutter"
require "lsp.rust"

local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

vim.cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach({})]])

require("metals").setup_dap()
--[[ require "lsp.metals" ]]

-- Auto install LanguageServers
-- for name, _ in pairs(servers) do
--   local server_available, server = lsp_installer.get_server(name)
--   if server_available then
--     if not server:is_installed() then
--       print("Installing " .. name)
--       vim.notify(string.format("Installing [%s] server", name), vim.log.levels.INFO)
--       server:install()
--     end
--   end
-- end

-- local servers = {
--   sumneko_lua = require "lsp.lua", -- /lua/lsp/lua.lua
--   -- jdtls = require "lsp.java", -- /lua/lsp/jdtls.lua
--   jsonls = require("lsp.jsonls"),
--   pyright = require("lsp.pyright"),
--   -- rust_analyzer = require 'lsp.rust_analyzer',
-- }
