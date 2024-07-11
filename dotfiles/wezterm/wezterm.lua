local wezterm = require('wezterm')
local config = wezterm.config_builder()

local user_home = os.getenv("HOME")

config.default_prog = { user_home .. "/.nix-profile/bin/fish" }

-- Without disabling Wayland the terminal will just crash at startup
config.enable_wayland = false

-- TODO: Remove when https://github.com/wez/wezterm/issues/5482 is fixed
--config.disable_default_mouse_bindings = true

config.window_close_confirmation = "NeverPrompt"

config.color_scheme_dirs = { wezterm.config_dir .. 'colors' }
config.color_scheme = 'theme'

config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'Symbols Nerd Font',
}

config.font_size = 16
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = "2cell",
  right = "2cell",
  top = "1cell",
  bottom = "1cell",
}

return config
