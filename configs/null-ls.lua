local present, null_ls = pcall(require, "null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  b.code_actions.proselint,
  b.code_actions.refactoring,
  b.diagnostics.proselint,


  b.code_actions.gitsigns,

  -- webdev stuff
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettierd,


  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- python
  b.formatting.black,

  -- rust
  -- b.formatting.rustfmt,

  -- go
  b.formatting.gofmt,
  b.formatting.goimports,
  b.code_actions.impl,

  -- php
  b.formatting.pint,
  b.formatting.blade_formatter,
  -- b.diagnostics.phpcs,
  b.diagnostics.phpstan,


}

null_ls.setup {
  debug = true,
  sources = sources,
}


-- add autocmds to run formatting on save for .go, .rs, and .py files
-- vim.cmd([[
--   augroup null_ls_formatting
--     autocmd!
--     autocmd BufWritePre *.go lua vim.lsp.buf.format((nil, 1000)
--     autocmd BufWritePre *.rs lua vim.lsp.buf.format((nil, 1000)
--     " autocmd BufWritePre *.ts lua vim.lsp.buf.format((nil, 1000)
--     " autocmd BufWritePre *.tsx lua vim.lsp.buf.format((nil, 1000)
--     " autocmd BufWritePre *.jsx lua vim.lsp.buf.format((nil, 1000)
--     autocmd BufWritePre *.py lua vim.lsp.buf.format((nil, 1000)
--   augroup END
-- ]])
