{config}: {
  enable = true;
  systemd.enable = true;
  xwayland.enable = true;

  settings = {
    "$mod" = "SUPER";
    "$scripts_path" = "/etc/profiles/per-user/${config.home.username}/bin";

    input =
      {
        kb_layout = "es";
        kb_options = "caps:escape";

        numlock_by_default = true;
        accel_profile = "flat";
      }
      // import ./binds.nix;

    env = import ./env.nix;

    monitor = [
      "DP-3, 1920x1080@240, 0x0, 1"

      # Fake monitor bug caused by Nvidia, need to be disable or it will crash when
      # you move around workspaces
      "Unknown-1, disable"
    ];

    exec-once = import ./exec-once.nix;

    general = {
      layout = "dwindle";
      cursor_inactive_timeout = 5;
      gaps_in = 3;
      gaps_out = 6;
      border_size = 4;
      "col.active_border" = "0xFF24283B";
      "col.inactive_border" = "0xFF1616E";
    };

    decoration = {
      rounding = 8;
      drop_shadow = false;
    };

    dwindle = {
      preserve_split = true;
      pseudotile = true;
    };

    windowrulev2 = import ./window-rules.nix;
  };
}
