local api = vim.api

-- Autocmd that will actually be in charging of starting the whole thing
local rest_nvim_group = api.nvim_create_augroup("rest-nvim", { clear = true })
api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "http" },
  callback = function()
    vim.cmd [[
      command! -buffer Http  :lua require'rest-nvim'.run()
      command! -buffer HttpCurl  :lua require'rest-nvim'.run(true)
      command! -buffer HttpLast  :lua require'rest-nvim'.last()
    ]]
    require("rest-nvim").setup({
      -- Open request results in a horizontal split
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    })

  end,
  group = rest_nvim_group,
})
