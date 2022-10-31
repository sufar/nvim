require'clipboard-image'.setup {
  -- Default configuration for all filetype
  default = {
    img_dir = "images",
    img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end, -- Example result: "2021-04-13-10-04-18"
    affix = "<\n  %s\n>" -- Multi lines affix
  },
  markdown = {
    img_dir ={"%:p:h", "images"},
    img_dir_txt = "images",
    img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end, -- Example result: "2021-04-13-10-04-18"
    affix = "![](%s)",
  },
}
