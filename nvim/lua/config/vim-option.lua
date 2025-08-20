local options = {
  swapfile       = false,   -- スワップファイルの生成
  backup         = false,   -- バックアップファイルの生成
  hidden         = true,    -- バッファが編集中でもその他のファイルを開けるようにするか否か
  confirm        = true,    -- 保存されていないファイルがあるときは終了前に保存確認するか否か
  autoread       = true,    -- 編集中のファイルが変更されたら自動で読み直すか否か
  updatetime     = 250,     -- CursorHoldイベントの間隔とswapファイル書き込み間隔（ms）

  number         = true,    -- 行番号の表示
  relativenumber = false,   -- 相対行番号にするか否か
  cursorline     = false,   -- カーソル行のハイライト

  tabstop        = 2,       -- Number of spaces that a <Tab> in the file counts for
  shiftwidth     = 2,       -- Number of spaces to use for each step of (auto)indent
  expandtab      = true,    -- Use the appropriate number of spaces to insert a <Tab>

  wrap           = false,   -- 行の折り返し

  cmdheight      = 1,       -- Number of screen lines to use for the command-line

  ignorecase     = true,    -- 検索で ignorecase を設定
  smartcase      = true,    -- 検索で smartcase を設定
  incsearch      = true,    -- インクリメンタル検索
  hlsearch       = true,    -- 検索時のハイライト

  showmatch      = true,    -- 対応する括弧をハイライト

  termguicolors  = true,    -- 24-bit RGBを利用する

  nrformats      = "octal", --

  mouse          = "a",     -- mouse support for all modes
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
  -- common options
  local options = {
    noremap = true,
    silent = true,
  }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

keymap("n", "ZZ", "<Nop>", {})
keymap("n", "ZQ", "<Nop>", {})
keymap("n", "Q", "<Nop>", {})

keymap("n", "j", "gj", {})
keymap("n", "k", "gk", {})
keymap("n", "gj", "j", {})
keymap("n", "gk", "k", {})
keymap("v", "j", "gj", {})
keymap("v", "k", "gk", {})
keymap("v", "gj", "j", {})
keymap("v", "gk", "k", {})

keymap("n", "J", ":bp<cr>", {})
keymap("n", "K", ":bn<cr>", {})
-- keymap("n", "gJ", ":tabmove -1<CR>", {})
-- keymap("n", "gK", ":tabmove +1<CR>", {})
keymap("n", "X", ":bd<cr>", {})

keymap("v", "<", "<gv", {})
keymap("v", ">", ">gv", {})

keymap("n", "Y", "y$", {})

-- autoread関連の自動コマンド
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif"
})

-- ファイル変更通知
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  command = "echohl WarningMsg | echo \"File changed on disk. Buffer reloaded.\" | echohl None"
})
