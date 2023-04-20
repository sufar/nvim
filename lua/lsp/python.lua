require 'lspconfig'.pyright.setup {
  cmd = { "pyright-langserver", "--stdio" },
  single_file_support = true,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
  },
  root_dir = require('lspconfig').util.root_pattern(".git"),
  filetypes = { "python" }
}


-- Setup dap for python
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  -- require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python", { console = 'externalTerminal' })
  require("dap-python").setup("python")
end)

-- Supported test frameworks are unittest, pytest and django. By default it
-- tries to detect the runner by probing for pytest.ini and manage.py, if
-- neither are present it defaults to unittest.
pcall(function()
  require("dap-python").test_runner = "pytest"
end)
