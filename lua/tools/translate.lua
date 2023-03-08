require("translate").setup({
  default = {
    command = "google",
    output = "floating",
    parse_before = "trim",
  },
  replace_symbols = {
    google = {},
    deepl_pro = {},
    deepl_free = {},
    translate_shell = {},
  },
  -- default = {
  --     command = "trans",
  -- },
  -- preset = {
  --     output = {
  --         split = {
  --             append = true,
  --         },
  --     },
  -- },
})
