vim.pack.add({
    {
        src = "https://github.com/neovim/nvim-lspconfig",
        version = "v2.7.0",
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        src = "https://github.com/mason-org/mason.nvim",
        version = "v2.2.1",
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        src = "https://github.com/mason-org/mason-lspconfig.nvim",
        version = "v2.1.0",
        event = { "BufReadPost", "BufNewFile" },
    },
})


-- mason: LSP サーバーのパッケージマネージャ
local ok, mason = pcall(require, 'mason')
if not ok then
    vim.notify("Failed to load mason", vim.log.levels.WARN)
    return
end
mason.setup()

-- mason-lspconfig: mason でインストール済みのサーバーを自動で vim.lsp.enable()
local ok2, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not ok2 then
    vim.notify("Failed to load mason-lspconfig", vim.log.levels.WARN)
    return
end
mason_lspconfig.setup({
    ensure_installed = {
        'lua_ls',
        'ts_ls',
    },
})

local keymap = vim.keymap.set
local s = { silent = true }
keymap("n", "==", function()
    vim.lsp.buf.format()
end, s)
