vim.cmd [[highlight Headline1 guibg=#201010 guifg=#ffa0a0 gui=bold]]
vim.cmd [[highlight Headline2 guibg=#102010 guifg=#a0f0a0 gui=bold]]
vim.cmd [[highlight Headline3 guibg=#101020 guifg=#a0a0ff gui=bold]]
vim.cmd [[highlight Headline4               guifg=#c0a0a0 gui=bold]]
-- vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
-- vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]

require("headlines").setup {
  markdown = {
    query = vim.treesitter.query.parse(
      "markdown",
      [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
    ),
    -- headline_highlights = { "Headline" },
    headline_highlights = {
      "Headline1",
      "Headline2",
      "Headline3",
      "Headline4",
      "Headline5",
      "Headline6",
    },
    bullet_highlights = {
      "@text.title.1.marker.markdown",
      "@text.title.2.marker.markdown",
      "@text.title.3.marker.markdown",
      "@text.title.4.marker.markdown",
      "@text.title.5.marker.markdown",
      "@text.title.6.marker.markdown",
    },
    -- bullets = { "◉", "○", "✸", "✿" },
    bullets = {},
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    -- dash_string = "-",
    dash_string = "",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = false,
    fat_headline_upper_string = "▃",
    fat_headline_lower_string = "🬂",
  },
  rmd = {
    query = vim.treesitter.query.parse(
      "markdown",
      [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
    ),
    treesitter_language = "markdown",
    headline_highlights = { "Headline" },
    bullet_highlights = {
      "@text.title.1.marker.markdown",
      "@text.title.2.marker.markdown",
      "@text.title.3.marker.markdown",
      "@text.title.4.marker.markdown",
      "@text.title.5.marker.markdown",
      "@text.title.6.marker.markdown",
    },
    bullets = { "◉", "○", "✸", "✿" },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    quote_highlight = "Quote",
    quote_string = "┃",
    fat_headlines = true,
    fat_headline_upper_string = "▃",
    fat_headline_lower_string = "🬂",
  },
  norg = {},
  org = {},
}
