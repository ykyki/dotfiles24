vim.pack.add({
    {
        src = "https://github.com/WTFox/jellybeans.nvim",
        version = "f75e0cfba0cdf3b7530301df8375367c29fbd310",
    },
})

require('jellybeans').setup({})
vim.cmd.colorscheme('jellybeans-warm')

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})
