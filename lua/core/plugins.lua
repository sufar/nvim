local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end
  }
}

-- Install your plugins here
return require('packer').startup(function(use)
  -- basic
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "folke/which-key.nvim"
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "RRethy/vim-illuminate" -- highlighting other uses of the current word under the cursor
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  --[[ use "ryanoasis/vim-devicons" ]]
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight, Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  use {
    'phaazon/hop.nvim',
    -- branch = 'v1.3.0', -- optional but strongly recommended
  }

  -- Comment
  --  use "b3nj5m1n/kommentary"

  -- java
  use "mfussenegger/nvim-jdtls"

  -- scala
  use({ 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } })

  -- rust
  use { "simrat39/rust-tools.nvim" }
  use "saecki/crates.nvim"

  -- sql
  use "nanotee/sqls.nvim"

  -- json
  use "b0o/schemastore.nvim"

  -- golang
  --[[ use "leoluz/nvim-dap-go" ]]
  use 'ray-x/go.nvim'
  use { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' } -- recommended if need floating window support

  -- flutter
  use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }


  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  -- You can alias plugin names
  use { 'dracula/vim', as = 'dracula' }
  use "folke/lsp-colors.nvim"
  use { "ellisonleao/gruvbox.nvim" }
  use "sainnhe/edge"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  --[[ use "williamboman/nvim-lsp-installer" -- simple to use language server installer ]]
  use "RishabhRD/nvim-lsputils"
  use "j-hui/fidget.nvim"

  -- mason
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  --  use "arkav/lualine-lsp-progress"
  --  use "nvim-lua/lsp-status.nvim"
  --  use "glepnir/lspsaga.nvim"
  --  use "mhartington/formatter.nvim"


  -- Debug
  use "mfussenegger/nvim-dap"
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, commit = "f7fc98ead677ffed72d4eec331eb439a7bad3bbf" }
  use "theHamsta/nvim-dap-virtual-text"
  use "mfussenegger/nvim-dap-python"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "nvim-treesitter/nvim-tree-docs"
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"

  -- aerial
  use "stevearc/aerial.nvim"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- rest
  use "NTBBloodbath/rest.nvim"

  -- colorizer
  use "norcalli/nvim-colorizer.lua"

  -- trouble
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  -- use "kevinhwang91/nvim-bqf"

  -- markdown
  use "ellisonleao/glow.nvim"
  use "ekickx/clipboard-image.nvim"

  -- sniprun
  use "michaelb/sniprun"

  -- bookmark
  use "MattesGroeger/vim-bookmarks"
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "kristijanhusak/line-notes.nvim"

  -- Distraction-free coding
  use "folke/zen-mode.nvim"
  use "folke/twilight.nvim"

  -- Neovim plugin to improve the default vim.ui interfaces 
  -- use "stevearc/dressing.nvim"

  use({
  "utilyre/barbecue.nvim",
  tag = "*",
  requires = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  after = "nvim-web-devicons", -- keep this if you're using NvChad
  config = function()
    require("barbecue").setup()
  end,
})

  -- Automatic indentation style detection for Neovim
  use "NMAC427/guess-indent.nvim"

  use "ellisonleao/glow.nvim"

  use "kperath/dailynotes.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
