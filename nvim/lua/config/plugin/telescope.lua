local action = require('telescope.actions')

local opts = {
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
      prompt  = { "─", "│", " ", "│", "┌", "┬", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "┴", "└" },
      -- preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
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
    grepping = {
      hidden = true,
    }
  },
  extensions = {
    frecency = {
      ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
      default_workspace = "CWD",
      show_scores = false,
      disable_devicons = false,
      path_display = { "filename_first" },
    },
  },
}

local telescope = require("telescope")
telescope.setup(opts)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<localleader>p', builtin.live_grep, {})
vim.keymap.set('n', '<localleader>b', builtin.buffers, {})
vim.keymap.set('n', '<localleader>h', builtin.help_tags, {})
vim.keymap.set('n', '<localleader>e', ":Telescope frecency<CR>", {})
