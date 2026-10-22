vim.pack.add({
    {
        src = "https://github.com/WTFox/jellybeans.nvim",
        version = "f75e0cfba0cdf3b7530301df8375367c29fbd310",
    },
})

-- Why not an opaque background: it hides tmux's window-style, so an inactive pane looks the same as the active one.
require('jellybeans').setup({ transparent = true })
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

require('plugin.copilot')
