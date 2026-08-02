vim.pack.add({
    {
        src = "https://github.com/folke/persistence.nvim",
        version = "v3.1.0",
    },
})

local mod_name = "persistence"
local ok, mod = pcall(require, mod_name)
if not ok then
    vim.notify("Failed to load " .. mod_name, vim.log.levels.WARN)
    return
end

mod.setup({})

local keymap = vim.keymap.set
local s = { silent = true }
keymap("n", "<leader>qs", function() mod.load() end, s)

-- 古いセッションファイルを起動時に掃除する.
-- 目的: 一度きり触ったディレクトリのセッションを溜め込まないため.
-- persistence.nvim には TTL が無いので, ここで mtime ベースに削除する.
local SESSION_TTL_SEC = 3 * 24 * 60 * 60
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local dir = vim.fn.stdpath("state") .. "/sessions"
        local now = os.time()
        for name, t in vim.fs.dir(dir) do
            if t == "file" then
                local path = dir .. "/" .. name
                local stat = vim.uv.fs_stat(path)
                if stat and (now - stat.mtime.sec) > SESSION_TTL_SEC then
                    os.remove(path)
                end
            end
        end
    end,
})
