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
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
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
  -- },
  {
    "tzachar/highlight-undo.nvim",
    opts = {
      duration = 300,
      undo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "u",
        map = "undo",
        opts = {},
      },
      redo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "<C-r>",
        map = "redo",
        opts = {},
      },
      highlight_for_count = true,
    },
    lazy = false,
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
    "thePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },
  {
    "nvim-neotest/neotest",
    lazy = true,
    event = "LspAttach",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      "haydenmeade/neotest-jest",
      "nvim-neotest/neotest-vim-test",
      "olimorris/neotest-phpunit",
      "vim-test/vim-test",
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
          require "neotest-jest" {
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
          require "neotest-go",
          require "neotest-vim-test" {
            allow_file_types = { "php", "sail" },
          },
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
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
          require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 2,
          })
        end
      },
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 1 },
        { name = "luasnip",  group_index = 2 },
        { name = "buffer",   group_index = 2 },
        { name = "path",     group_index = 2 },
        { name = "copilot",  group_index = 2 },
        { name = "tailwind",  group_index = 2 },
        { name = "nvim_lua", group_index = 3 },
      },
    },
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings "gopher"
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings "dap"
    end,
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings "dap_go"
    end,
  },
  -- To use a extras plugin
  { import = "custom.configs.extras.symbols-outline", },


  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  { "nvim-neotest/nvim-nio" },

  {
    "folke/neodev.nvim",
    opts = {
    }
  },
  {
    'laytan/tailwind-sorter.nvim',
    dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim'},
    build = 'cd formatter && npm ci && npm run build',
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "typescript", "typescriptreact", "javascript", "javascriptreact", "svelte", "vue" },
    config = function()
      require("nvim-ts-autotag").setup()
    end
  }
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   lazy = true,
  --   event = "VeryLazy", -- Using LSPAttach doesn't help on files where there's only a linter and no language server. DiagnosticChanged loads properly, but the plugin doesn't show anything until a save happens
  --   config = function()
  --     require("lsp_lines").setup()
  --
  --     -- https://github.com/folke/lazy.nvim/issues/620
  --     vim.diagnostic.config({ virtual_lines = false, virtual_text = true }, require("lazy.core.config").ns)
  --   end,
  -- }
}

return plugins
