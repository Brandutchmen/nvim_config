local overrides = require "custom.configs.overrides"

vim.o.spell = true

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  ["williamboman/nvim-lsp-installer"] = {
    event = "BufRead",
    config = function()
      local lsp_installer = require "nvim-lsp-installer"

      lsp_installer.on_server_ready(function(server)
        local opts = {}
        server:setup(opts)
        vim.cmd [[ do User LspAttachBuffers ]]
      end)
    end,
  },
  ["m4xshen/autoclose.nvim"] = {
    event = "BufEnter",
    config = function()
      require("autoclose").setup()
    end,
  },
  -- To make a plugin not be loaded
  {
    "NvChad/nvim-colorizer.lua",
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  {
    "tzachar/highlight-undo.nvim",
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup {}
    end,
  },
  {
    "tzachar/local-highlight.nvim",
    config = function()
      require("local-highlight").setup {}
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = overrides.copilot,
    cmd = "Copilot",
    config = function()
      require("copilot").setup()
    end,
  },
  {
    "ThePrimeagen/vim-be-good",
    lazy = false,
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
  {
    "nvim-neotest/neotest",
    lazy = true,

    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-vim-test",
      "olimorris/neotest-phpunit",
      "vim-test/vim-test"
    },
    config = function()
      require("neotest").setup {
        adapters = {
          -- require "neotest-phpunit" {
          --   phpunit_cmd = function()
          --     return "./laravel-sail-helper"
          --   end,
          --   filter_dirs = function()
          --     return { "vendor" }
          --   end,
          -- },
          require "neotest-go",
          require("neotest-vim-test")({
            allow_file_types = { "php", 'sail' }
          })
        },
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 1 },
        { name = "copilot", group_index = 2 },
        { name = "luasnip", group_index = 3 },
        { name = "buffer", group_index = 3 },
        { name = "nvim_lua", group_index = 3 },
        { name = "path", group_index = 2 },
      },
    },
  },
  -- To use a extras plugin
  -- { import = "custom.configs.extras.symbols-outline", },
}

return plugins
