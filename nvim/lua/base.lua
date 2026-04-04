vim.opt.swapfile   = false
vim.opt.backup     = false
vim.opt.autoread   = true
vim.opt.hidden     = true
vim.opt.confirm    = true
vim.opt.updatetime = 250

vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation
vim.opt.expandtab   = true
vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.softtabstop = -1
vim.opt.smarttab    = true
vim.opt.autoindent  = true

vim.opt.clipboard:prepend({ "unnamedplus" })

vim.opt.termguicolors = true
vim.opt.number        = true
vim.opt.numberwidth   = 2       -- Width of the line number column
vim.opt.signcolumn    = "yes:1" -- Always show sign column
vim.opt.hlsearch      = true
vim.opt.ignorecase    = true
vim.opt.smartcase     = true
vim.opt.matchtime     = 1
vim.opt.list          = true -- Show whitespace characters
vim.opt.listchars     = "tab: ,eol:󰌑"
vim.opt.wrap          = false
vim.opt.cursorline    = true

vim.opt.exrc          = true

vim.g.netrw_liststyle = 1

vim.pack.add({
    { src = "https://github.com/tpope/vim-surround",      version = "v2.2" },
    { src = "https://github.com/jiangmiao/auto-pairs",    version = "v2.0.0" },
    { src = "https://github.com/junegunn/vim-easy-align", version = "2.10.0" },
})

-- auto-pairs
vim.g.AutoPairsFlyMode = 0
vim.g.AutoPairsMapBS   = 1
vim.g.AutoPairsMapCh   = 1

-- easy-align
vim.keymap.set("v", "<Enter>", "<Plug>(EasyAlign)")
