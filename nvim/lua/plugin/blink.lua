vim.pack.add({
    { 
      src = "https://github.com/saghen/blink.cmp",
      version = "v1.10.1",
      event = { "VimEnter" },
    },
})

local mod_name = "blink.cmp"
local ok, mod = pcall(require, mod_name)
if not ok then
  vim.notify("Failed to load " .. mod_name, vim.log.levels.WARN)
  return
end

-- see https://cmp.saghen.dev/configuration/general.html
mod.setup({
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'none',
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-e>'] = { 'cancel', 'fallback' },
    },

    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      documentation = { auto_show = false },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    cmdline = {
      enabled = true,
      keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },
})

