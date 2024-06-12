local wezterm = require('wezterm')
local config = wezterm.config_builder()

local user = os.getenv("USER")

config.default_prog = { "/etc/profiles/per-user/" .. user .. "/bin/fish" }

config.enable_wayland = false

config.window_close_confirmation = "NeverPrompt"

config.color_scheme_dirs = { wezterm.config_dir .. 'colors' }
config.color_scheme = 'tokyonight'

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
