local options = {
  -- guifont = "monospace:h17", -- the font used in graphical neovim applications
  hidden = true,             -- required to keep multiple buffers and open multiple buffers
  -- title = true,              -- set the title of window to the value of the titlestring
  -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
  showcmd = false,
  ruler = false,
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  encoding = "utf-8",                      -- always uses UTF-8 as the default encoding
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  --guifont = "monospace:h17",               -- the font used in graphical neovim applications
  -- the font used in graphical neovim applications
  foldmethod = "expr",                     -- fold method
  foldexpr = "nvim_treesitter#foldexpr()", -- fold with nvim_treesitter
  foldenable = false,                      -- default to not fold
  foldlevel = 99                           -- fold everywhere
}

vim.opt.spelllang:append "cjk" -- disable spellchecking for asian characters (VIM algorithm does not support it)
vim.opt.shortmess:append "c"   -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append "I"   -- don't show the default intro message
vim.opt.whichwrap:append "<,>,[,],h,l"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd('autocmd Filetype lua setlocal ts=2 sw=2 expandtab')
vim.cmd('autocmd Filetype js setlocal ts=2 sw=2 expandtab')
vim.cmd('autocmd Filetype javascript setlocal ts=2 sw=2 expandtab')
vim.cmd('autocmd Filetype json setlocal ts=2 sw=2 expandtab')
vim.cmd('autocmd Filetype css setlocal ts=2 sw=2 expandtab')
vim.cmd('autocmd Filetype html setlocal ts=2 sw=2 expandtab')
vim.cmd('autocmd Filetype xml setlocal ts=2 sw=2 expandtab')
vim.cmd('autocmd Filetype yaml setlocal ts=2 sw=2 expandtab')
vim.cmd('autocmd Filetype java setlocal ts=4 sw=4 expandtab')
vim.cmd('autocmd Filetype slint setlocal ts=4 sw=4 expandtab')

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
vim.cmd [[set guifont="JetBrains MonoNerd Font:h3" ]]

-- visual code open current file or current project
vim.cmd [[command! -nargs=0 CodeFile execute ":!code " . getcwd() . " -g %:p\:" . line(".") . ":" . col(".")]]
vim.cmd [[command! -nargs=0 Code execute ":!code " . getcwd()]]

-- intellij idea open current file
vim.cmd [[command! -nargs=0 Idea execute ":!intellij-idea-ultimate-edition %:p"]]

-- support *.slint file
vim.cmd('autocmd BufEnter *.slint :setlocal filetype=slint')
