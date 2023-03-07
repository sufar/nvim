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
  {
    "sainnhe/edge",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[
        set background=dark
        colorscheme edge
      ]])
    end,
  },

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
    event = { "UIEnter" },
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
    }
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
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
    }
  },

  -------------------------------- dap -----------------------------

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "jay-babu/mason-nvim-dap.nvim" },
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
    },
    event = { "UIEnter" },
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
  },

  {
    "j-hui/fidget.nvim",
    event = { "LspAttach" },
  },

  {
    'scalameta/nvim-metals',
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    event = { "UIEnter" },
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      { "saecki/crates.nvim" }
    },
    lazy = true
  },

  {
    "mfussenegger/nvim-jdtls",
    lazy = true
  },

  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' }
    }
  },
  {
    'ray-x/go.nvim',
    dependencies = {
      {
        'ray-x/guihua.lua',
        build = 'cd lua/fzy && make'
      } -- recommended if need floating window support
    }
  },

  -------------------------------- tools ----------------------------
  {
    "windwp/nvim-autopairs",
    event = { "UIEnter" },
  },

  -- zen mode
  {
    "folke/zen-mode.nvim",
    dependencies = {
      { "folke/twilight.nvim" },
    },
    event = { "UIEnter" },
  },

  -- bookmark
  {
    "MattesGroeger/vim-bookmarks",
    event = { "UIEnter" },
  },
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    event = { "UIEnter" },
  },
  {
    "kristijanhusak/line-notes.nvim",
    event = { "UIEnter" },
  },


  -- sql
  {
    "tpope/vim-dadbod",
    dependencies = {
      { "kristijanhusak/vim-dadbod-ui" },
    },
    lazy = true
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
    lazy = true
  },

  -- colorizer
  {
    "norcalli/nvim-colorizer.lua",
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
  },

  {
    "kperath/dailynotes.nvim",
    lazy = true
  }
}

require("lazy").setup(plugins, {})
