local utils = {}
local Path = require "plenary.path"

utils.get_separator = function()
  return Path.path.sep
end

utils.get_mason_home = function ()
  return vim.fn.stdpath "data" .. utils.get_separator() .. "mason" .. utils.get_separator()
end

utils.get_home = function ()
  return Path.path.home .. utils.get_separator()
end

utils.is_windows = function ()
  return vim.loop.os_uname().version:match('Windows')
end

return utils
