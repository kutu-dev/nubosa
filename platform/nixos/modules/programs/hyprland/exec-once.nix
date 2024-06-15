{config}: [
  "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

  # Start the clipboard daemon
  "wl-paste --type text --watch cliphist store"

  # Start the wallpaper manager
  "swww-daemon"
  "swww img ${config.xdg.userDirs.pictures}/wallpapers/android-girl.png -t none"

  # Start the `ags` shell
  "ags"

  # Apps with window rules that will be reverted
  "vesktop"
  "spotify"
  "steam"
]
