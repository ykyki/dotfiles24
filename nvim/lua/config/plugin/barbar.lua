local barbar = require("barbar")

local opt = {
  animation = false,
  auto_hide = false,
  clickable = false,

  -- Valid options are 'left' (the default), 'previous', and 'right'
  focus_on_close = 'left',

  hide = {
    extensions = true,
    inactive   = false,
    alternate  = true,
    visible    = true,
  },
}

vim.g.barbar_auto_setup = false
barbar.setup(opt)
