vim.pack.add({
    {
        src = "https://github.com/nvim-tree/nvim-web-devicons",
        version = "v0.100",
    },
    {
        src = "https://github.com/nvim-tree/nvim-tree.lua",
        version = "v1.13.0",
    },
})

local mod_name = "nvim-tree"
local ok, mod = pcall(require, mod_name)
if not ok then
    vim.notify("Failed to load " .. mod_name, vim.log.levels.WARN)
    return
end

mod.setup({
    view = {
        width = 40,
        side = "left",
    },
    renderer = {
        group_empty = true,
    },
    update_focused_file = {
        enable = true,
    },
    git = {
        enable = true,
    },
    diagnostics = {
        enable = true,
    },
})

local keymap = vim.keymap.set
local s = { silent = true }
keymap("n", "\\", "<cmd>NvimTreeToggle<CR>", s)

-- 操作方法メモ
--
-- グローバル:
--   \              ツリーの toggle (開閉)
--
-- ツリー内 (デフォルトキーマップ):
--   Enter / o      ファイルを開く / ディレクトリ展開
--   <C-v>          縦分割で開く
--   <C-x>          横分割で開く
--   <C-t>          新しいタブで開く
--   a              作成 (末尾に / でディレクトリ)
--   d              削除
--   r              リネーム
--   x              カット
--   c              コピー
--   p              ペースト
--   y              ファイル名をコピー
--   Y              相対パスをコピー
--   gy             絶対パスをコピー
--   R              ツリー再読込
--   H              隠しファイル表示切替
--   I              gitignore 対象表示切替
--   q              ツリーを閉じる
--   g?             ヘルプ (全キーマップ一覧)
