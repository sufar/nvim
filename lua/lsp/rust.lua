local opts = {}
local dap_rust = require("lsp.dap.dap-rust")

-- rust-tools options
opts.tools = {
  autoSetHints = true,
  inlay_hints = {
    show_parameter_hints = true,
    parameter_hints_prefix = "",
    other_hints_prefix = "",
  },
}

-- all the opts to send to nvim-lspconfig
-- these override the defaults set by rust-tools.nvim
-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
-- https://rust-analyzer.github.io/manual.html#features
opts.server = {
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = "crate"
      },
      cargo = {
        allFeatures = true
      },
      checkOnSave = {
        -- default: `cargo check`
        command = "clippy"
      },
    },
    inlayHints = {
      lifetimeElisionHints = {
        enable = true,
        useParameterNames = true
      },
    },
  }
}
opts.dap = dap_rust.dap

require('rust-tools').setup(opts)

-- local dap = require('dap')
-- dap.configurations.rust = {
--   {
--     name = "Launch",
--     type = "lldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     args = {},
--     pid = require('dap.utils').pick_process,
--
--     -- 💀
--     -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--     --
--     --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--     --
--     -- Otherwise you might get the following error:
--     --
--     --    Error on launch: Failed to attach to the target process
--     --
--     -- But you should be aware of the implications:
--     -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--
--     runInTerminal = false,
--
--     -- 💀
--     -- If you use `runInTerminal = true` and resize the terminal window,
--     -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
--     -- To avoid that uncomment the following option
--     -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
--     postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
--   },
-- }
