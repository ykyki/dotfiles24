local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.hl.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})

-- Auto-reload files changed outside of Neovim
autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
    pattern = '*',
    command = "if mode() != 'c' | checktime | endif",
})
autocmd('FileChangedShellPost', {
    pattern = '*',
    command = 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None',
})

-- Restore cursor position
autocmd('BufReadPost', {
    pattern = '*',
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
})
