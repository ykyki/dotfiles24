vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal          = 0
vim.g.tex_conceal                   = ""
vim.g.vim_markdown_math             = 1

-- support front matter of various format
vim.g.vim_markdown_frontmatter      = 1 -- for YAML format
vim.g.vim_markdown_toml_frontmatter = 1 -- for TOML format
vim.g.vim_markdown_json_frontmatter = 1 -- for JSON format


vim.g.vim_markdown_fenced_languages = {
  'csharp=cs',
  'ini=dosini',
}
