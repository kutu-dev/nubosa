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
      }
      // import ./binds.nix;

    env = import ./env.nix;

    monitor = [
      "DP-3, 1920x1080@240, 0x0, 1"
      ", preferred, auto, 1"
    ];
  };
}
