vim.pack.add({
    {
        src = "https://github.com/stevearc/conform.nvim",
        version = "v9.1.0",
        event = { "BufWritePre" },
    },
})

local mod_name = "conform"
local ok, mod = pcall(require, mod_name)
if not ok then
    vim.notify("Failed to load " .. mod_name, vim.log.levels.WARN)
    return
end

mod.setup({
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*",
--     callback = function(args)
--         mod.format({ bufnr = args.buf })
--     end,
-- })
