[
  # GTK settings
  "GDK_BACKEND, wayland,x11,*"
  # TODO: After installing the GTK theme
  # "GTK_THEME, tokyo-night"

  # QT settings
  "QT_QPA_PLATFORM, wayland;xcb"
  "XCURSOR_SIZE, 24"
  # TODO: After installing the posy cursors
  # "XCURSOR_THEME, posy-black"
  # TODO: After installing the QT theme
  # "QT_STYLE_OVERRIDE, kvantum"

  # SDL2 settings
  "SDL_VIDEODRIVER, wayland"

  # Clutter settings
  "CLUTTER_BACKEND, wayland"

  # XDG settings
  "XDG_CURRENT_DESKTOP, Hyprland"
  "XDG_SESSION_TYPE, wayland"
  "XDG_SESSION_DESKTOP, Hyprland"

  # Nvidia settings
  # TODO: After installing the Nvidia drivers
  # "GBM_BACKEND, nvidia-drm"
  # "__GLX_VENDOR_LIBRARY_NAME, nvidia"
  # "LIBVA_DRIVER_NAME, nvidia"
  # "__GL_GSYNC_ALLOWED, 1"
  # "__GL_VRR_ALLOWED, 0"
  # "WLR_DRM_NO_ATOMIC, 1"
]
