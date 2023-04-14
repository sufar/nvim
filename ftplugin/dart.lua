-- whick-key bind.
local status_ok, which_key = pcall(require, "which-key")
if status_ok then
  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  }

  local mappings = {
    C = {
      name = "Dart",
      r = { "<cmd>FlutterRun<CR>", "Flutter Run" },
      d = { "<Cmd>FlutterDevices<CR>", "Flutter Devices" },
      E = { "<Cmd>FlutterEmulators<CR>", "Flutter Emulators" },
      s = { "<Cmd>FlutterReload<CR>", "Flutter Reload" },
      R = { "<Cmd>FlutterRestart<CR>", "Flutter Restart" },
      q = { "<Cmd>FlutterQuit<CR>", "Flutter Quit" },
      x = { "<Cmd>FlutterDetach<CR>", "Flutter Detach" },
      e = { "<Cmd>FlutterOutlineToggle<CR>", "Flutter Outline Toggle" },
      o = { "<Cmd>FlutterOutlineOpen<CR>", "Flutter Outline Open" },
      t = { "<Cmd>FlutterDevTools<CR>", "Flutter Dev Tools" },
      f = { "<Cmd>FlutterCopyProfilerUrl<CR>", "Flutter Copy ProfilerUrl" },
      v = { "<Cmd>FlutterVisualDebug<CR>", "Flutter Visual Debug" },
      c = { "<Cmd>FlutterLogClear<CR>", "Flutter Log Clear" },
      l = { "<Cmd>FlutterLspRestart<CR>", "Flutter Lsp Restart" },
      p = { "<Cmd>FlutterPubGet<CR>", "Flutter Pub Get" },
      u = { "<Cmd>FlutterPubUpgrade<CR>", "Flutter Pub Upgrade" },
    }
  }

  which_key.register(mappings, opts)
end
