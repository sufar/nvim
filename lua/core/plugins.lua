local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -------------------------------------- colorscheme -----------------------------------
  {
    "sainnhe/edge",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },

  {
    'dracula/vim',
    priority = 1000,
    name = 'dracula',
  },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        options = {
          cursorline = true,
          transparency = true
        },
        plugins = {
          nvim_tree = false,
        },
        colors = {
          -- cursorline = "#bebebe"
        }
      })
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

  -------------------------------------- core plugins ---------------------------------

  -- I have a separate config.mappings file where I require which-key.
  -- With lazy the plugin will be automatically loaded when it is required somewhere
  {
    "folke/which-key.nvim",
    lazy = true
  },
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = { "InsertEnter", "CmdlineEnter" },
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-buffer" },
      { "saadparwaiz1/cmp_luasnip" },
      { "kristijanhusak/vim-dadbod-completion" },
      -- { "tzachar/cmp-tabnine", build = "./install.sh" },
    },
    lazy = true
  },

  {
    "L3MON4D3/LuaSnip",
    -- in nvim-cmp config file require luasnip
    lazy = true,
    dependencies = {
      { "rafamadriz/friendly-snippets" },
    },
  },


  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    event = { "UIEnter" },
  },

  {
    "goolord/alpha-nvim",
    event = { "UIEnter" },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = { "UIEnter" },
  },

  {
    "akinsho/bufferline.nvim",
    event = { "UIEnter" },
  },

  {
    "numToStr/Comment.nvim",
    event = { "VeryLazy" },
  },

  {
    "mg979/vim-visual-multi",
    event = { "VeryLazy" },
  },

  {
    "ahmedkhalf/project.nvim",
    event = { "UIEnter" },
  },

  {
    "akinsho/toggleterm.nvim",
    lazy = true
  },

  {
    "folke/trouble.nvim",
    event = { "LspAttach" },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-media-files.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    lazy = true
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { "mrjones2014/nvim-ts-rainbow" }, -- Rainbow parentheses for neovim using tree-sitter.
      { "windwp/nvim-ts-autotag" },
      { "nvim-lua/plenary.nvim" },
    },
    build = ":TSUpdate",
    event = { "UIEnter" },
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = true
  },

  {
    'sindrets/diffview.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' }
    },
    lazy = true
  },

  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup()
    end,
    event = { "UIEnter" },
  },

  -- highlighting other uses of the current word under the cursor
  {
    "RRethy/vim-illuminate",
    event = { "UIEnter" },
  },

  {
    "folke/todo-comments.nvim",
    event = { "UIEnter" },
    config = function()
      require('todo-comments').setup()
    end
  },

  -- delete buffer
  {
    "moll/vim-bbye",
    event = { "UIEnter" },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "UIEnter" }
  },

  {
    "stevearc/aerial.nvim",
    lazy = true,
  },

  -------------------------------- dap -----------------------------

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "jay-babu/mason-nvim-dap.nvim" },
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
    },
    event = { "LspAttach" },
  },

  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
  },

  ------------------------------- lsp ------------------------------
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    lazy = true
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true
  },

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = { "LspAttach" },
  },

  {
    'scalameta/nvim-metals',
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    lazy = true
  },

  {
    "simrat39/rust-tools.nvim",
    lazy = true
  },

  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
    end,
    lazy = true,
  },

  -- json yaml
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  {
    "mfussenegger/nvim-jdtls",
    lazy = true
  },

  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' }
    },
    lazy = true
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -------------------------------- tools ----------------------------
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
  },

  -- zen mode
  {
    "folke/zen-mode.nvim",
    dependencies = {
      { "folke/twilight.nvim" },
    },
    lazy = true,
  },

  -- bookmark
  {
    "MattesGroeger/vim-bookmarks",
    event = { "UIEnter" },
  },
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    lazy = true,
  },
  {
    "kristijanhusak/line-notes.nvim",
    lazy = true,
  },

  -- sql
  {
    "tpope/vim-dadbod",
    dependencies = {
      { "kristijanhusak/vim-dadbod-ui" },
    },
    event = { "UIEnter" }
  },

  -- markdown
  {
    "ellisonleao/glow.nvim",
    lazy = true,
  },
  {
    "ekickx/clipboard-image.nvim",
    lazy = true,
  },

  -- rest
  {
    "NTBBloodbath/rest.nvim",
    event = { "VeryLazy" },
  },

  -- colorizer
  {
    "norcalli/nvim-colorizer.lua",
    event = { "VeryLazy" },
  },

  {
    "kperath/dailynotes.nvim",
    event = { "VeryLazy" },
  },

  -- sudo pacman -S lazygit
  {
    "kdheepak/lazygit.nvim",
    event = { "VeryLazy" },
  },

  {
    "phaazon/hop.nvim",
    event = { "VeryLazy" },
  },

  -- {
  --   "uga-rosa/translate.nvim",
  --   event = { "VeryLazy" },
  -- },

  {
    "kristijanhusak/vim-carbon-now-sh",
    event = { "VeryLazy" },
  },

  -- tmux
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    config = function()
      return require("tmux").setup()
    end
  }
}

local opts = {
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = false, -- get a notification when new updates are found
  }
}

require("lazy").setup(plugins, opts)
