local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})
--

vim.wo.relativenumber = true

-- additional filetypes
vim.filetype.add({
 extension = {
  templ = "templ",
 },
})

-- copilot.lua
-- vim.g.copilot_assume_mapped = true

