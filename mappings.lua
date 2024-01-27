---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

-- Extras example
M.symbols_outline = {
  n = {
    ["<leader>cs"] = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
  },
}

-- more keybinds!

M.todo = {
  n = {
    ["<leader>ft"] = { "<cmd>:TodoTelescope<cr>", "Find todos" },
  },
}
return M
