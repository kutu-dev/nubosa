{
  config,
  pkgs,
  ...
}: let
  createScript = scriptName: pkgs.writeShellScriptBin (builtins.elemAt (pkgs.lib.strings.splitString "." scriptName) 0) (builtins.readFile (../scripts + "/${scriptName}"));

  extraPackages = with pkgs; [
    wl-clipboard
    slurp
    grim
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    socat
  ];

  extraScripts = [
    (createScript "system-notification.sh")
    (createScript "start-desktop-portals.sh")
    (createScript "screenshot.sh")
    (createScript "select-area-screenshot.sh")
    (createScript "screenshot-to-clipboard.sh")
    (createScript "select-area-screenshot-to-clipboard.sh")
    (createScript "revert-startup-apps-window-rules.sh")
  ];

in {
  home.homeDirectory = "/home/${config.home.username}";

  home.packages = pkgs.callPackage ../../common/modules/packages.nix {} ++ extraPackages ++ extraScripts;

  wayland.windowManager.hyprland = import ./programs/hyprland/default.nix {inherit config;};

  services.udiskie.enable = true;

  programs.tofi = import ./programs/tofi.nix;
}
