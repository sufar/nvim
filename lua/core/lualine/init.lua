builtin = {}
builtin.lualine = {
  active = true,
  style = "zugle",
  options = {
    icons_enabled = nil,
    component_separators = nil,
    section_separators = nil,
    theme = nil,
    disabled_filetypes = nil,
    globalstatus = false,
  },
  sections = {
    lualine_a = nil,
    lualine_b = nil,
    lualine_c = nil,
    lualine_x = nil,
    lualine_y = nil,
    lualine_z = nil,
  },
  inactive_sections = {
    lualine_a = nil,
    lualine_b = nil,
    lualine_c = nil,
    lualine_x = nil,
    lualine_y = nil,
    lualine_z = nil,
  },
  tabline = nil,
  extensions = nil,
  on_config_done = nil,
}

-- avoid running in headless mode since it's harder to detect failures
if #vim.api.nvim_list_uis() == 0 then
  return
end

require("core.lualine.styles").update()

local lualine = require "lualine"
lualine.setup(builtin.lualine)

if builtin.lualine.on_config_done then
  builtin.lualine.on_config_done(lualine)
end
