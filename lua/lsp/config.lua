local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local servers = {
  sumneko_lua = require "lsp.settings.sumneko_lua", -- /lua/lsp/lua.lua
  jsonls = require("lsp.settings.jsonls"),
  pyright = require("lsp.settings.pyright"),
  clangd = require "lsp.settings.clangd",
  gopls = require "lsp.settings.gopls",
  -- rust_analyzer = require 'lsp.rust_analyzer',
  yamlls = require "lsp.settings.yamlls",
  sqls = require "lsp.settings.sqls",
  -- sqlls = require "lsp.settings.sqlls",
  taplo = require "lsp.settings.taplo_toml",
  bashls = require "lsp.settings.bashls",
  -- volar = require "lsp.settings.volar",
  vuels = require "lsp.settings.vuels",
  tsserver = require "lsp.settings.tsserver",
  html = require "lsp.settings.html",
  lemminx = require "lsp.settings.lemminx_xml",
  cssls = require "lsp.settings.cssls",
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for name, m in pairs(servers) do
  local opts = m.config;
  if opts then
    opts.on_attach = function(client, bufnr)
      -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
      -- require('core.keybindings').maplsp(client, bufnr)
      if m.on_attach then
        m.on_attach(client, bufnr)
      end
      vim.notify(string.format("Starting [%s] server", name), vim.log.levels.INFO)
    end
    -- vim.tbl_deep_extend("force", defaults, custom_config)
    -- opts.flags = {
    --   debounce_text_changes = 150,
    -- }
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true
    opts.capabilities = capabilities;
  end

  lspconfig[name].setup(opts)
end

local M = {}
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
