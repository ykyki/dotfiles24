local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
  exclude_path_patterns = {
    "/node_modules/",
  },
  formatter_by_ft = {
    lua = formatters.lsp,
    sh = formatters.shfmt,
    json = formatters.lsp,
    yaml = formatters.lsp,
    javascript = formatters.lsp,
    typescript = formatters.prettierd,
    typescriptreact = formatters.prettierd,
    html = formatters.lsp,
    css = formatters.lsp,
    scss = formatters.lsp,
    -- markdown = { formatters.prettierd,
    --   formatters.shell({
    --     cmd = { "markdown-toc", "-i", "%" },
    --     tempfile = function()
    --       return vim.fn.expand("%") .. '.markdown-toc-temp'
    --     end
    --   }) },
    -- python = formatters.black,
    rust = formatters.lsp,
    go = {
      -- Use a tempfile instead of stdin
      -- formatters.shell({
      --   cmd = { "goimports-reviser", "-rm-unused", "-set-alias", "-format", "%" },
      --   tempfile = function()
      --     return vim.fn.expand("%") .. '.formatter-temp'
      --   end
      -- }),
      formatters.shell({ cmd = { "gofmt" } }),
    },
    java = formatters.lsp,
  },
  fallback_formatter = {
    formatters.remove_trailing_whitespace,
  }
})
