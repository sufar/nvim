local MASON_HOME = vim.fn.stdpath "data" .. "/mason"
local on_attach = function(client, bufnr)
  require 'jdtls'.setup_dap({ hotcodereplace = 'auto' })
  require 'jdtls.setup'.add_commands()
  require('jdtls.dap').setup_dap_main_class_configs()

  -- whick-key bind.
  local status_ok, which_key = pcall(require, "which-key")
  local which_key_config = require("core.whichkey")
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
      -- java
      ["O"] = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
      ["c"] = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test Class" },
      ["m"] = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "Test Nearest Method" },
      ["v"] = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
    }

    local vopts = {
      mode = "v",
      prefix = "f",
      buffer = bufnr,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local vmappings = {
      ["e"] = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
      ["m"] = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
    }

    which_key.register(f_nmappings, f_nopts)
    which_key.register(which_key_config.g_nmappings, which_key_config.g_nopts)
    which_key.register(vmappings, vopts)
  end
end
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
      maven = {
        userSettings = os.getenv("HOME") .. '/.m2/settings.xml',
        globalSettings = os.getenv("HOME") .. '/.m2/settings.xml',
      },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      templates = {
        fileHeader = {
          "/**",
          " * ${type_name}",
          " * @author ${user}",
          " */",
        },
        typeComment = {
          "/**",
          " * ${type_name}",
          " * @author ${user}",
          " */",
        },
      },
    },
    project = {
      resourceFilters = {
        "node_modules",
        ".git",
        ".idea",
        ".settings"
      },
    },
    import = {
      exclusions = {
        "**/node_modules/**",
        "**/.metadata/**",
        "**/archetype-resources/**",
        "**/META-INF/maven/**",
        "**/.git/**",
        "**/.idea/**",
      },
    },
    eclipse = {
      downloadSources = true
    },
    signatureHelp = { enabled = true },
    contentProvider = { preferred = 'fernflower' },
    server = {
      launchMode = "Hybrid",
    },
    maven = {
      downloadSources = true,
      updateSnapshots = true,
    },
    sources = {
      organizeImports = {
        starThreshold = 9999;
        staticStarThreshold = 9999;
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    },
  },
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities
  },
  flags = {
    allow_incremental_sync = true,
  },
  on_attach = on_attach,
}
require('jdtls').start_or_attach(config)
--[[ local dap = require("dap") ]]
--[[ dap.configurations.java = { ]]
--[[           { ]]
--[[               type = "java", ]]
--[[               request = "launch", ]]
--[[               name = "Launch Java" ]]
--[[           }, ]]
--[[           { ]]
--[[               type = "cppdbg", ]]
--[[               request = "launch", ]]
--[[               name = "Launch CPP" ]]
--[[           } ]]
--[[         } ]]
--[[]]
--[[ local root_dir = require('jdtls.setup').find_root({'pom.xml'}) ]]
--[[ vim.notify(root_dir) ]]
