require "lsp.lua"

require("mason").setup()
require("mason-lspconfig").setup()

local mason_home = vim.fn.stdpath "data" .. "/mason"
require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,

  jdtls = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "java" },
      callback = function()
        local java_config = require("lsp.java")
        require('jdtls').start_or_attach(java_config)
      end,
      group = vim.api.nvim_create_augroup("jdtls", { clear = true })
    })
  end,

  sqls = function()
    require('lspconfig').sqls.setup {
      on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
      end
    }
  end,

  rust_analyzer = function()
    local config = require("lsp.rust")
    require("rust-tools").setup(config)
    require('crates').setup()
  end,

  groovyls = function()
    require 'lspconfig'.groovyls.setup {
      cmd = { "groovy-language-server" },
      filetypes = { "groovy" },
      root_dir = require('lspconfig').util.root_pattern("*.groovy")
    }
  end,

  cssls = function()
    require("lsp.css").setup()
  end,

  yamlls = function()
    require('lsp.yamlls').setup()
  end,

  jsonls = function()
    require('lsp.jsonls').setup()
  end,

  gopls = function()
    require("lsp.go")
  end,

  pyright = function()
    require("lsp.python")
  end,

  -- volar = function ()
  --   vim.notify("volar init...")
  --   require("lsp.vue")
  -- end
}

-- require("mason-nvim-dap").setup({
--   automatic_setup = true,
-- })
-- require 'mason-nvim-dap'.setup_handlers {
--   function(source_name)
--     -- all sources with no handler get passed here
--
--
--     -- Keep original functionality of `automatic_setup = true`
--     require('mason-nvim-dap.automatic_setup')(source_name)
--   end,
-- }
