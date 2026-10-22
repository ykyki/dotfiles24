vim.pack.add({
    -- {
    --   src = 'https://github.com/sainnhe/sonokai',
    --   version = 'b023c5280b16fe2366f5e779d8d2756b3e5ee9c3',
    -- },
    {
        src = 'https://github.com/rebelot/kanagawa.nvim',
        version = 'aef7f5cec0a40dbe7f3304214850c472e2264b10',
    },
})

-- Why not an opaque background: it hides tmux's window-style, so an inactive pane looks the same as the active one.
require('kanagawa').setup({ transparent = true })
vim.cmd.colorscheme('kanagawa')
