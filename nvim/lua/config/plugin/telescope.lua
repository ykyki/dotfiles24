local telescope = require("telescope")

local tele_opts = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      width = 0.8,
      horizontal = {
        mirror = false,
        prompt_position = "top",
      },
      vertical = {
        mirror = false,
        prompt_position = "top",
      },
    },
    border = {},
    borderchars = {
      { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      -- prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
      -- results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      -- preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      prompt = { "─", "│", " ", "│", "┌", "┬", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "┴", "└" },
      preview = { "─", "│", "─", " ", "─", "┐", "┘", "─" },
    },
    file_ignore_patterns = { "node_modules/*", ".git" },
    path_display = { "truncate" },
    dynamic_preview_title = true,
    color_devicons = true,
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    frecency = {
      db_root = vim.fn.stdpath("state"),
      ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
      show_scores = false,
      show_unindexed = true,
      disable_devicons = false,
      db_safe_mode = false,
      auto_validate = true,
    },
  },
}

telescope.setup(tele_opts)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
