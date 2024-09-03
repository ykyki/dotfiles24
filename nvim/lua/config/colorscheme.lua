local colorscheme = "gruvbox"

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
vim.o.background = "dark" -- or "light" for light mode
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found.", vim.log.levels.WARN)
  return
end

require("config.plugin." .. colorscheme)
