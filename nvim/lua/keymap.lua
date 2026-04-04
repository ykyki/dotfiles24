local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "
keymap("n", "<space>", "<Nop>")

keymap("n", "j", "gj", s)
keymap("n", "k", "gk", s)
keymap("n", "gT", "<cmd>tabnew<CR>", s)
keymap("n", "<C-w>\\", "<cmd>vsplit<CR>", s)
keymap("n", "<C-w>-", "<cmd>split<CR>", s)
keymap("n", "<Leader>==", ":lua vim.lsp.buf.format()<CR>", s)
keymap("n", "<Leader>ex", "<cmd>Ex %:p:h<CR>") -- Open Netrw in the current file's directory

-- ########
-- vim.pack
-- ########
-- info: to delete a package, run ":lua vim.pack.del({'package_name'})"
keymap("n", "<leader>ps", function()
  -- update plugins
  vim.pack.update()

  -- remove unused plugins
  local unused = vim.iter(vim.pack.get())
    :filter(function(p) return not p.active end)
    :map(function(p) return p.spec.name end)
    :totable()
  if #unused > 0 then
    vim.pack.del(unused)
  end
end, s)

