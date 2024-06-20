[
  # Hyprland settings
  "HYPRCURSOR_THEME, Bibata-Modern-Classic"
  "HYPRCURSOR_SIZE, 24"

  # GTK settings
  "GDK_BACKEND, wayland,x11,*"

  # QT settings
  "QT_QPA_PLATFORM, wayland;xcb"
  "XCURSOR_SIZE, 24"
  "T_QPA_PLATFORM, wayland"
  "XCURSOR_THEME, Bibata-Modern-Classic"
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

  # Electron settings
  "NIXOS_OZONE_WL, 1"

  # Nvidia settings
  "GBM_BACKEND, nvidia-drm"
  "__GLX_VENDOR_LIBRARY_NAME, nvidia"
  "LIBVA_DRIVER_NAME, nvidia"
  "__GL_GSYNC_ALLOWED, 1"
  "__GL_VRR_ALLOWED, 0"
  "WLR_DRM_NO_ATOMIC, 1"
]
