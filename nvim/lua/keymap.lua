local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "
keymap("n", "<space>", "<Nop>")

keymap("n", "j", "gj", s)
keymap("n", "k", "gk", s)
keymap("n", "gT", "<cmd>tabnew<CR>", s)
keymap("n", "<C-w>\\", "<cmd>vsplit<CR>", s)
keymap("n", "<C-w>-", "<cmd>split<CR>", s)
keymap("n", "<Leader>ex", "<cmd>Ex %:p:h<CR>") -- Open Netrw in the current file's directory

-- Copy `path:line` (or `path:l1-l2` in visual) for pasting into AI agents
keymap("n", "<leader>yl", function()
    local ref = vim.fn.expand("%:.") .. ":" .. vim.fn.line(".")
    vim.fn.setreg("+", ref)
    vim.notify("copied: " .. ref)
end, s)
keymap("x", "<leader>yl", function()
    local path = vim.fn.expand("%:.")
    local l1, l2 = vim.fn.line("v"), vim.fn.line(".")
    local lo, hi = math.min(l1, l2), math.max(l1, l2)
    local ref = path .. ":" .. lo .. (lo ~= hi and ("-" .. hi) or "")
    vim.fn.setreg("+", ref)
    vim.notify("copied: " .. ref)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, s)

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
