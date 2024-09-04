local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  vim.notify("lspconfig is not installed.", vim.log.levels.WARN)
  return
end

local opt = {
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
  -- This setting has no relation with the `automatic_installation` setting.
  ---@type string[]
  ensure_installed = {
    "lua_ls",
  },

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  ---@type boolean
  automatic_installation = false,

  -- See `:h mason-lspconfig.setup_handlers()`
  ---@type table<string, fun(server_name: string)>?
  handlers = {
    function(server_name) -- default handler (optional)
      lspconfig[server_name].setup({
        on_attach = function(client, bufnr)
          local bufopts = { silent = true, buffer = bufnr }
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', '==', vim.lsp.buf.format, bufopts)
        end,
      })
    end,
  }
}

require("mason-lspconfig").setup(opt)
