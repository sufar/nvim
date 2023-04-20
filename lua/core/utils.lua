local M = {}
local Path = require "plenary.path"

M.get_separator = function()
  return Path.path.sep
end

M.get_mason_home = function()
  return vim.fn.stdpath "data" .. M.get_separator() .. "mason" .. M.get_separator()
end

M.get_home = function()
  return Path.path.home .. M.get_separator()
end

M.is_windows = function()
  return vim.loop.os_uname().version:match('Windows')
end

function M.is_lsp_installed(name)
  local _, clients = pcall(function()
    return require("mason-lspconfig").get_installed_servers()
  end)
  for _, client in ipairs(clients) do
    if client == name then
      return true
    end
  end
  return false
end

return M
