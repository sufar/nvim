require("mason").setup()
require("mason-lspconfig").setup()

local MASON_HOME = vim.fn.stdpath "data" .. "/mason"

require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,
  ["jdtls"] = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "java" },
      callback = function()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        local workspace_dir = os.getenv("HOME") .. '/.workspace/' .. project_name
        local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
        extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
        local bundles = {
          vim.fn.glob(MASON_HOME .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
            , 1),
        }
        vim.list_extend(bundles,
          vim.split(vim.fn.glob(MASON_HOME .. "/packages/java-test/extension/server/*.jar", 1), "\n"))
        local config = {
          cmd = { MASON_HOME .. '/packages/jdtls/bin/jdtls', '-data', workspace_dir,
            '-javaagent:' .. MASON_HOME .. '/packages/jdtls/lombok.jar' },
          root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw', 'pom.xml' }, { upward = true })[1]),
          settings = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-1.8",
                  path = os.getenv("JAVA8_HOME"),
                  default = true,
                },
                {
                  name = "JavaSE-11",
                  path = os.getenv("JAVA11_HOME"),
                }, {
                  name = "JavaSE-17",
                  path = os.getenv("JAVA_HOME"),
                }
              },
            }
          },
          init_options = {
            bundles = bundles,
            extendedClientCapabilities = extendedClientCapabilities
          }
        }
        require('jdtls').start_or_attach(config)
        require 'jdtls'.setup_dap({ hotcodereplace = 'auto' })
        require 'jdtls.setup'.add_commands()
        require('jdtls.dap').setup_dap_main_class_configs()
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
