local bufferline = require('bufferline')

local opts = {
  mode = "buffers",
  style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
  themable = true,
  numbers = "none",
  buffer_close_icon = ' ',
  modified_icon = '● ',
  close_icon = ' ',
}

bufferline.setup({
  options = opts
})


vim.keymap.set("n", "J", ":BufferLineCyclePrev<CR>", { silent = true, noremap = true, })
vim.keymap.set("n", "K", ":BufferLineCycleNext<CR>", { silent = true, noremap = true, })
vim.keymap.set("n", "gJ", ":BufferLineMovePrev<CR>", { silent = true, noremap = true, })
vim.keymap.set("n", "gK", ":BufferLineMoveNext<CR>", { silent = true, noremap = true, })
