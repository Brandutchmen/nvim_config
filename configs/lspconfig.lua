local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "phpactor", "astro", "gopls", "pyright", "yamlls", "dockerls", "cmake", "terraformls", "vimls", "tailwindcss" }

for _, lsp in ipairs(servers) do
  local config = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig[lsp].setup(config)
end-- 
-- lspconfig.pyright.setup { blabla}

lspconfig.tailwindcss.setup({
  filetypes = {
    'templ'
    -- include any other filetypes where you need tailwindcss
  },
  init_options = {
    userLanguages = {
        templ = "html"
    }
  }
})


