vim.pack.add({
    {
        src = "https://github.com/akinsho/bufferline.nvim",
        version = "v4.9.1",
        event = { "VimEnter" },
    },
})

local mod_name = "bufferline"
local ok, mod = pcall(require, mod_name)
if not ok then
    vim.notify("Failed to load " .. mod_name, vim.log.levels.WARN)
    return
end

mod.setup({
    options = {
        mode = "buffers",
        style_preset = mod.style_preset.default,
        themable = true,
        numbers = "none",
        buffer_close_icon = ' ',
        modified_icon = '● ',
        close_icon = ' ',
    }
})


local keymap = vim.keymap.set
local s = { silent = true }
keymap("n", "J", ":BufferLineCyclePrev<CR>", s)
keymap("n", "K", ":BufferLineCycleNext<CR>", s)
keymap("n", "gJ", ":BufferLineMovePrev<CR>", s)
keymap("n", "gK", ":BufferLineMoveNext<CR>", s)
keymap("n", "X", ":bdelete<CR>", s)
