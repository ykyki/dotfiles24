local options = {
  swapfile       = false, -- スワップファイルの生成
  backup         = false, -- バックアップファイルの生成
  hidden         = true,  -- バッファが編集中でもその他のファイルを開けるようにするか否か
  confirm        = true,  -- 保存されていないファイルがあるときは終了前に保存確認するか否か
  autoread       = true,  -- 編集中のファイルが変更されたら自動で読み直すか否か

  number         = true,  -- 行番号の表示
  relativenumber = false, -- 相対行番号にするか否か
  cursorline     = true,  -- カーソル行のハイライト

  tabstop        = 2,     -- Number of spaces that a <Tab> in the file counts for
  shiftwidth     = 2,     -- Number of spaces to use for each step of (auto)indent
  expandtab      = true,  -- Use the appropriate number of spaces to insert a <Tab>

  wrap           = false, -- 行の折り返し

  cmdheight      = 1,     -- Number of screen lines to use for the command-line

  hlsearch       = true,  -- When there is a previous search pattern, highlight all its matches
  showmatch      = true,  -- When a bracket is inserted, briefly jump to the matching one

  -- showmode = false, -- we don't need show mode because we see in the lualine statusline (Insert, Visual, etc)

  termguicolors  = true, -- 24-bit RGBを利用する

  mouse          = "a",  -- mouse support for all modes
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- クリップボード設定
vim.opt.clipboard:prepend({ "unnamedplus" })

vim.api.nvim_set_var("mapleader", "<Space>")
vim.api.nvim_set_var("maplocalleader", ",")

-------------------------------
-- keymaps
local function keymap(mode, lhs, rhs, opts)
  local options = {
    noremap = true,
    silent = true,
  }

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
keymap("n", "<S-k>", ":tabn<CR>", {})
keymap("n", "<S-j>", ":tabp<CR>", {})
