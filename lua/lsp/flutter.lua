local FLUTTER_HOME = os.getenv("FLUTTER_HOME")
if not FLUTTER_HOME then
  return
end

local dap = require("dap")
local MASON_HOME = vim.fn.stdpath "data" .. "/mason"

require("flutter-tools").setup {
  debugger = {
    enabled = true,
    register_configurations = function(paths)
      dap.adapters.dart = {
        type = "executable",
        command = "node",
        args = { MASON_HOME .. "/packages/dart-debug-adapter/extension/out/dist/debug.js", "flutter" }
      }

      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch flutter",
          dartSdkPath = os.getenv('FLUTTER_HOME') .. "/bin/cache/dart-sdk/",
          flutterSdkPath = os.getenv('FLUTTER_HOME'),
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
        }
      }

    end,
  },
  flutter_path = FLUTTER_HOME .. "/bin/flutter", -- <-- this takes priority over the lookup
  lsp = {
    settings = {
      analysisExcludedFolders = {
        FLUTTER_HOME
      },
    }
  }
}
