local opts = {}

opts.config ={
	settings = {

    python = {
      -- exclude = { ".venv" },
      -- venvPath = "./.venv/",
      -- executionEnvironments = {
      --   root = "./",
      --
      --   venv = "./",
      -- }
      -- venvPath = ".",
      -- venv = ".venv",

      -- autoSearchPaths = true,
      -- diagnosticMode = "workspace",
      -- useLibraryCodeForTypes = true,

      -- autoComplete = {
      --   extraPaths = "/soft/anaconda3/envs/tensorflow/lib/python3.9/site-packages",
      -- },
      -- analysis = {
      --   extraPaths = "/soft/anaconda3/envs/tensorflow/lib/python3.9/site-packages",
      -- },

      -- autoComplete = {
      --   extraPaths = "/data/workspaces/zugle/tensorflow/hello-tf/venv/lib/python3.10/site-packages",
      -- },
      -- analysis = {
      --   typeCheckingMode = "off",
      --   extraPaths = "/data/workspaces/zugle/tensorflow/hello-tf/venv/lib/python3.10/site-packages",
      -- }
    }
	},
}

opts.on_attach = function(client, bufnr)
  -- require('dap-python').setup("/data/workspaces/zugle/tensorflow/hello-tf/venv/bin/python", {})
  require('dap-python').setup("python", {})
  -- require('dap-python').setup("/soft/anaconda3/envs/tensorflow/bin/python", {})

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
      ["m"] = { "<Cmd>lua require('dap-python').test_method()<CR>", "Test Method" },
      ["c"] = { "<cmd>lua require('dap-python').test_class()<CR>", "Test Class" },
      ["t"] = { "<cmd>lua require('dap-python').debug_selection()<CR>", "Debug Selection"},
    }

    local f_vopts = {
      mode = "v",
      prefix = "f",
      buffer = bufnr,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local f_vmappings = {
      ["t"] = { "<cmd>lua require('dap-python').debug_selection()<CR>", "Debug Selection"},
    }

    which_key.register(f_nmappings, f_nopts)
    which_key.register(f_vmappings, f_vopts)
  end
end

return opts
