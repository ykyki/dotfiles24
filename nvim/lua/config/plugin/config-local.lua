require("config-local").setup({
  -- Config file patterns to load (lua supported)
  config_files = { ".nvim/local.vim", ".nvim/local.lua" },

  -- Where the plugin keeps files data
  hashfile = vim.fn.stdpath("data") .. "/config-local",

  -- Create autocommands (VimEnter, DirectoryChanged)
  autocommands_create = true,

  -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
  commands_create = true,

  -- Disable plugin messages (Config loaded/ignored)
  silent = true,
})
