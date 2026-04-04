vim.pack.add({
    { 
      src = "https://github.com/ibhagwan/fzf-lua",
      version = "5cbe58ca48c4c4a2fbe5e324b854596d8242711e",
      event = { "VimEnter" },
    },
})

local ok, mod = pcall(require, "fzf-lua")
if not ok then
  vim.notify("Failed to load fzf-lua.", vim.log.levels.WARN)
  return
end

local actions = require('fzf-lua.actions')
mod.setup({
})

local keymap = vim.keymap.set
local s = { silent = true }
keymap("n", "<C-p>", function() mod.files() end)
keymap("n", "<leader>fg",function() mod.live_grep() end)

