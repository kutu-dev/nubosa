[
  # Avoid some process to take a long time to open
  #"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
  #"start-desktop-portals"

  # Start the clipboard daemon
  "wl-paste --type text --watch cliphist store"
  
  "revert-startup-apps-window-rules"

  # Apps with window rules that will be reverted
  "vesktop"
  "spotify"
  "steam"
]
