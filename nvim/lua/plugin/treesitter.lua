vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "v0.10.0",
    },
    {
        src = "https://github.com/HiPhish/rainbow-delimiters.nvim",
        version = "v0.11.0",
    },
})

-- rainbow-delimiters (デフォルト設定で有効化)
local ok2, rainbow = pcall(require, "rainbow-delimiters.setup")
if not ok2 then
    vim.notify("Failed to load rainbow-delimiters", vim.log.levels.WARN)
    return
end

rainbow.setup({})
