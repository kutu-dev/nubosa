local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.enable_wayland = false

config.window_close_confirmation = "NeverPrompt"

config.color_scheme_dirs = { wezterm.config_dir .. 'colors' }
config.color_scheme = 'tokyonight'

config.font = wezterm.font('JetbrainsMono Nerd Font', { weight = 'Medium' })
config.font_size = 24
config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font('JetbrainsMono Nerd Font', { weight = 'Bold' }),
  }
}

config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = "2cell",
  right = "2cell",
  top = "1cell",
  bottom = "1cell",
}

return config
