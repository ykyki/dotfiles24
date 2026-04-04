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
        'denols',
        'gopls',
        'rust_analyzer',
        'bashls',
    },
})

vim.diagnostic.config({ virtual_text = true })

local keymap = vim.keymap.set
local s = { silent = true }

-- see also default keymaps: https://neovim.io/doc/user/lsp/#_quickstart
--     "gra" (Normal and Visual mode) is mapped to vim.lsp.buf.code_action()
--     "gri" is mapped to vim.lsp.buf.implementation()
--     "grn" is mapped to vim.lsp.buf.rename()
--     "grr" is mapped to vim.lsp.buf.references()
--     "grt" is mapped to vim.lsp.buf.type_definition()
--     "grx" is mapped to vim.lsp.codelens.run()
--     "gO" is mapped to vim.lsp.buf.document_symbol()
--     CTRL-S (Insert mode) is mapped to vim.lsp.buf.signature_help()
--     v_an and v_in fall back to LSP vim.lsp.buf.selection_range() if treesitter is not active.
--     gx handles textDocument/documentLink. Example: with gopls, invoking gx on "os" in this Go code will open documentation externally:
keymap("n", "gd", vim.lsp.buf.definition, s)
keymap("n", "gD", vim.lsp.buf.declaration, s)
keymap("n", "gi", vim.lsp.buf.implementation, s)
keymap("n", "gr", vim.lsp.buf.references, s)
-- keymap("n", "gy", vim.lsp.buf.type_definition, s)
keymap("n", "gh", vim.lsp.buf.hover, s)
-- keymap({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, s)
keymap("n", "<F2>", vim.lsp.buf.rename, s)
keymap("n", "[d", vim.diagnostic.goto_prev, s)
keymap("n", "]d", vim.diagnostic.goto_next, s)
-- keymap("n", "<leader>e", vim.diagnostic.open_float, s)
-- keymap("n", "<leader>q", vim.diagnostic.setloclist, s)

keymap("n", "==", vim.lsp.buf.format, {})
