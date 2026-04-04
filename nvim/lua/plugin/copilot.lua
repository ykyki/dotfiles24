vim.pack.add({
    {
        src = "https://github.com/github/copilot.vim",
        version = "a12fd5672110c8aa7e3c8419e28c96943ca179be",
        event = { "BufEnter" },
    },
})

vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<C-/>", "<Plug>(copilot-dismiss)")
