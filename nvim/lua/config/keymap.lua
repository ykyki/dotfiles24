local function keymap(mode, lhs, rhs, opts)
  local options = { noremap = true }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

keymap("n", "j", "gj", {})
keymap("n", "k", "gk", {})

-- stay in indent mode
keymap("v", "<", "<gv", {})
keymap("v", ">", ">gv", {})

-- buffer operations
keymap("n", "<S-k>", ":bnext<CR>", {})
keymap("n", "<S-j>", ":bprevious<CR>", {})
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)

