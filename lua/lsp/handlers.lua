local diagnostic_float = {
  winblend = 0,
  curdir_window = {
    enable = false,
    highlight_dirname = true,
  },
  -- You can define a function that returns a table to be passed as the third
  -- argument of nvim_open_win().
  win_opts = function()
    local width = math.floor(vim.o.columns * 0.7)
    local height = math.floor(vim.o.lines * 0.7)
    return {
      border = "rounded",
      width = width,
      height = height,
    }
  end,
}

local float = {
  focusable = true,
  style = "minimal",
  border = "rounded",
}

local default_diagnostic_config = {
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = "" },
      { name = "DiagnosticSignWarn",  text = "" },
      { name = "DiagnosticSignHint",  text = "" },
      { name = "DiagnosticSignInfo",  text = "" },
    },
  },
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = diagnostic_float,
}
vim.diagnostic.config(default_diagnostic_config)
for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
