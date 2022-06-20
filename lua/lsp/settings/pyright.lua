local opts = {}

opts.config ={
	settings = {

    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
	},
}

opts.on_attach = function(client, bufnr)
  require('dap-python').setup("python", {})

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
