-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Dart
local opts = {}
opts.adapter = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/.config/nvim/resources/flutter/Dart-Code/out/dist/debug.js", "flutter" }
}

opts.dap = {
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

return opts
