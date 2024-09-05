-- lazy.nvim: https://lazy.folke.io/usage
-- Basic Usage:
-- :Lazy sync
-- :Lazy health

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

-- vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

local plugins = {
  -- Lua Util
  {
    -- https://github.com/nvim-lua/plenary.nvim
    "nvim-lua/plenary.nvim"
  },

  -- Vim Util
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("config.plugin.nvim-autopairs")
    end,
  },
  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
      require("config.plugin.Comment")
    end
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "machakann/vim-highlightedyank",
    event = "VeryLazy",
    config = function()
      vim.g.highlightedyank_highlight_duration = 300
    end,
  },
  {
    "michaeljsmith/vim-indent-object",
    event = "VeryLazy",
  },

  -- Easymotion
  -- {
  --   "phaazon/hop.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("config.plugin.hop")
  --   end,
  -- },

  {
    -- Status Line
    -- https://github.com/nvim-lualine/lualine.nvim
    "nvim-lualine/lualine.nvim",
    event = "BufEnter",
    config = function()
      require("config.plugin.lualine")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    }
  },
  {
    -- Tab Line
    -- https://github.com/romgrk/barbar.nvim
    'romgrk/barbar.nvim',
    version = '^1.0.0',              -- optional: only update when a new 1.x version is released
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    event = "BufEnter",
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
  },
  -- {
  --   -- Extensible UI for Neovim notifications and LSP progress messages.
  --   -- https://github.com/j-hui/fidget.nvim
  --   "j-hui/fidget.nvim",
  --   opts = {
  --     -- options
  --   },
  -- },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter" },
    config = function()
      require("config.plugin.telescope")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-frecency.nvim",
    }
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
    dependencies = { "kkharji/sqlite.lua" }
  },

  -- Tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost" },
    build = ":TSUpdateSync",
    config = function()
      require("config.plugin.nvim-treesitter")
    end,
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/nvim-tree-docs" },
      { "yioneko/nvim-yati" },
    },
  },

  -- Filer
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   event = "VimEnter",
  --   branch = "main",
  --   config = function()
  --     require("config.plugin.neo-tree")
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --   }
  -- },


  -- Git Integration
  {
    -- https://github.com/lewis6991/gitsigns.nvim
    "lewis6991/gitsigns.nvim",
    event = "VimEnter",
    config = function()
      require("config.plugin.gitsigns")
    end,
  },

  -- Highlight
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("config.plugin.colorizer")
    end,
  },
  {
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    "lukas-reineke/indent-blankline.nvim",
    event = "VimEnter",
    main = "ibl",
    config = function()
      require("config.plugin.indent_blankline")
    end,
  },
  {
    -- https://github.com/aklt/plantuml-syntax
    "aklt/plantuml-syntax",
    ft = "plantuml",
  },

  -- Local Config
  {
    -- https://github.com/klen/nvim-config-local
    "klen/nvim-config-local",
    event = "BufEnter",
    config = function()
      require("config.plugin.config-local")
    end,
  },

  -- Language Server Protocol(LSP)
  {
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
  },
  {
    -- https://github.com/williamboman/mason.nvim
    "williamboman/mason.nvim",
    config = function()
      require("config.plugin.mason")
    end,
  },
  {
    -- https://github.com/williamboman/mason-lspconfig.nvim
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("config.plugin.mason-lspconfig")
    end,
  },

  -- {
  --   -- https://github.com/elentok/format-on-save.nvim
  --   "elentok/format-on-save.nvim",
  --   event = "BufEnter",
  --   config = function()
  --     require("config.plugin.format-on-save")
  --   end,
  -- },

  -- Markdown
  {
    "plasticboy/vim-markdown",
    ft = "markdown",
    config = function()
      require("config.plugin.vim-markdown")
    end,
  },

  -- Color Scheme
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  }
}

local ok_lazy, lazy = pcall(require, "lazy")
if not ok_lazy then
  vim.notify("lazy.nvim is not installed.", vim.log.levels.ERROR)
  return
end

lazy.setup(plugins, {
  lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
  defaults = {
    lazy = true,
  }
})
