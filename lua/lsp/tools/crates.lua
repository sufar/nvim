require('crates').setup()

-- vim.cmd[[autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }]]

local api = vim.api
-- autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }
-- Autocmd that will actually be in charging of starting the whole thing
local rust_crates_group = api.nvim_create_augroup("rust-crates", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "toml" },
  callback = function()
    require('cmp').setup.buffer { sources = { { name = 'crates' } } }
  end,
  group = rust_crates_group,
})
