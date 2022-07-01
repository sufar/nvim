local opts = {}

opts.config = {}

opts.on_attach = function(client, bufnr)
  -- whick-key bind.
  local status_ok, which_key = pcall(require, "which-key")
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
      ["r"] = { "<cmd>FlutterRun<CR>", "Flutter Run" },
      ["d"] = { "<Cmd>FlutterDevices<CR>", "Flutter Devices" },
      ["E"] = { "<Cmd>FlutterEmulators<CR>", "Flutter Emulators" },
      ["s"] = { "<Cmd>FlutterReload<CR>", "Flutter Reload" },
      ["R"] = { "<Cmd>FlutterRestart<CR>", "Flutter Restart" },
      ["q"] = { "<Cmd>FlutterQuit<CR>", "Flutter Quit" },
      ["x"] = { "<Cmd>FlutterDetach<CR>", "Flutter Detach" },
      ["e"] = { "<Cmd>FlutterOutlineToggle<CR>", "Flutter Outline Toggle" },
      ["o"] = { "<Cmd>FlutterOutlineOpen<CR>", "Flutter Outline Open" },
      ["t"] = { "<Cmd>FlutterDevTools<CR>", "Flutter Dev Tools" },
      ["f"] = { "<Cmd>FlutterCopyProfilerUrl<CR>", "Flutter Copy ProfilerUrl" },
      ["v"] = { "<Cmd>FlutterVisualDebug<CR>", "Flutter Visual Debug" },
      ["c"] = { "<Cmd>FlutterLogClear<CR>", "Flutter Log Clear" },
      ["l"] = { "<Cmd>FlutterLspRestart<CR>", "Flutter Lsp Restart" },
      ["p"] = { "<Cmd>FlutterPubGet<CR>", "Flutter Pub Get" },
      ["u"] = { "<Cmd>FlutterPubUpgrade<CR>", "Flutter Pub Upgrade" },
    }

    which_key.register(f_nmappings, f_nopts)
  end
end

return opts
