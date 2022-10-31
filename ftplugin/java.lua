-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
--

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4


local env = {
  -- HOME = vim.loop.os_homedir(),
  HOME = os.getenv("HOME"),
  JAVA_HOME = os.getenv("JAVA_HOME")
}

-- local path = package.searchpath("~/.config/nvim/resources/java", "lombok-*")
-- vim.notify(path)

-- local java_home = "/soft/jdk-11.0.14"
local java_home = "/soft/jdk-17.0.3.1"
local java8_home = "/soft/jdk1.8.0_202"
local java11_home = "/soft/jdk-11.0.14"
local function get_java_home()
  return java_home or env.JAVA_HOME
end

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = env.HOME .. '/.workspace/' .. project_name

-- lsp-status
--local lsp_status = require('lsp-status')
--lsp_status.register_progress()

local on_attach = function(client, bufnr)
  require 'jdtls'.setup_dap({ hotcodereplace = 'auto' })
  require 'jdtls.setup'.add_commands()
  require('jdtls.dap').setup_dap_main_class_configs()
  require("aerial").on_attach(client, bufnr)
  require "core.fidget"
  require 'illuminate'.on_attach(client)
  -- lsp_status.on_attach(client)
  --  require 'lspsaga'.init_lsp_saga()
  --  require('core.keybindings').maplsp(bufnr)

  -- Kommentary
  --      vim.api.nvim_set_keymap("n", "<leader>/", "<plug>kommentary_line_default", {})
  --      vim.api.nvim_set_keymap("v", "<leader>/", "<plug>kommentary_visual_default", {})

  -- require'formatter'.setup{
  --    filetype = {
  --        java = {
  --            function()
  --                return {
  --                    exe = 'java',
  --                    args = { '-jar', os.getenv('HOME') .. '/.local/jars/google-java-format.jar', vim.api.nvim_buf_get_name(0) },
  --                    stdin = true
  --                }
  --            end
  --        }
  --    }
  --}

  -- save buffer auto format
  --      vim.api.nvim_exec([[
  --        augroup FormatAutogroup
  --          autocmd!
  --          autocmd BufWritePost *.java FormatWrite
  --        augroup end
  --      ]], true)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  --      vim.api.nvim_exec([[
  --          hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkGray
  --          hi LspReferenceText cterm=bold ctermbg=red guibg=DarkGray
  --          hi LspReferenceWrite cterm=bold ctermbg=red guibg=DarkGray
  --          augroup lsp_document_highlight
  --            autocmd!
  --            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --          augroup END
  --      ]], false)


  -- local create_command = vim.api.nvim_buf_create_user_command
  -- create_command(bufnr, 'J', remove_unused_imports(), {
  --   nargs = 0,
  -- })

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


local capabilities = {
  workspace = {
    configuration = true
  },
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true
      }
    }
  }
}

local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- java-debug
local bundles = {
  vim.fn.glob(env.HOME .. "/.config/nvim/resources/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
}
-- vscode-java-test
vim.list_extend(bundles, vim.split(vim.fn.glob(env.HOME .. "/.config/nvim/resources/java/vscode-java-test/server/*.jar"), "\n"))

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    get_java_home() .. '/bin/java', -- or '/path/to/java11_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-Xmx2g',
    '-javaagent:' .. env.HOME .. '/.config/nvim/resources/java/lombok-1.18.24.jar',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', env.HOME .. '/.config/nvim/resources/java/jdtls-server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', env.HOME .. '/.config/nvim/resources/java/jdtls-server/config_linux',
    '-data', workspace_dir
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --[[ root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }), ]]
  root_dir = require('jdtls.setup').find_root({ 'build.gradle', 'pom.xml' }),
  -- root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      home = get_java_home(),
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
      configuration = {
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = java8_home,
            default = true,
          },
          {
            name = "JavaSE-11",
            path = java11_home
          }
        },
        maven = {
          userSettings = env.HOME .. '/.m2/settings_huawei.xml',
          globalSettings = env.HOME .. '/.m2/settings_huawei.xml',
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
      }
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities
  },
  --   handlers = lsp_status.extensions.jdtls.setup(),
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    allow_incremental_sync = true,
  }
}

-- lsp-status
--config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

function remove_unused_imports()
  vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
  vim.cmd('packadd cfilter')
  vim.cmd('Cfilter /main/')
  vim.cmd('Cfilter /The import/')
  vim.cmd('cdo normal dd')
  vim.cmd('cclose')
  vim.cmd('wa')
end
