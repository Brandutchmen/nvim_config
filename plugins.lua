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
    -- {
    --   "NvChad/nvim-colorizer.lua",
    --   enabled = false
    -- },

    -- All NvChad plugins are lazy-loaded by default
    -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
    -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
    -- {
    --   "mg979/vim-visual-multi",
    --   lazy = false,
    -- }
    {
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
      opts = overrides.copilot,
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
          { name = "nvim_lsp", group_index = 2 },
          { name = "copilot", group_index = 2 },
          { name = "luasnip", group_index = 2 },
          { name = "buffer", group_index = 2 },
          { name = "nvim_lua", group_index = 2 },
          { name = "path", group_index = 2 },
        },
      },
    },
    -- To use a extras plugin
    -- { import = "custom.configs.extras.symbols-outline", },
}

return plugins
