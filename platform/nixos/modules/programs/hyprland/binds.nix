{
  bind = [
    # Exit binds
    "$mod, Q, killactive"
    "$mod SHIFT, Q, exit"

    # Move focus
    "$mod, H, movefocus, l"
    "$mod, L, movefocus, r"
    "$mod, K, movefocus, u"
    "$mod, J, movefocus, d"

    # Switch to workspace
    "$mod, 1, workspace, 1"
    "$mod, 2, workspace, 2"
    "$mod, 3, workspace, 3"
    "$mod, 4, workspace, 4"
    "$mod, 5, workspace, 5"
    "$mod, 6, workspace, 6"
    "$mod, 7, workspace, 7"

    # Move window to workspace
    "$mod SHIFT, 1, movetoworkspace, 1"
    "$mod SHIFT, 2, movetoworkspace, 2"
    "$mod SHIFT, 3, movetoworkspace, 3"
    "$mod SHIFT, 4, movetoworkspace, 4"
    "$mod SHIFT, 5, movetoworkspace, 5"
    "$mod SHIFT, 6, movetoworkspace, 6"
    "$mod SHIFT, 7, movetoworkspace, 7"

    # Floating windows
    "$mod, X, togglefloating"

    # Toggle fullscreen
    "$mod, M, fullscreen, 0"
    "$mod SHIFT, M, fullscreen, 1"

    # Screenshots
    "$mod, S, exec, $scripts_path/screenshot-to-clipboard"
    "$mod SHIFT, S, exec, $scripts_path/select-area-screenshot-to-clipboard"
    "$mod CONTROL, S, exec, $scripts_path/screenshot"
    "$mod CONTROL SHIFT, S, exec, $scripts_path/select-area-screenshot"

    # Change wallpaper
    # TODO: Change when wallpaper manager is finished
    "$mod, W, exec, swww img $(find ~/pictures/wallpapers/* -type f | sort -R | head -1) -t wipe"

    # App shortcuts
    "$mod, T, exec, wezterm"
  ];

  bindm = [
    # Floating windows mouse control
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];
}
