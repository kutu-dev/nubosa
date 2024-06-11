{
  config,
  pkgs,
  ...
}: 
let
  createScript = scriptName: pkgs.writeShellScriptBin (builtins.elemAt (pkgs.lib.strings.splitString "." scriptName) 0) (builtins.readFile (../scripts + "/${scriptName}"));

  extraPackages = [
    pkgs.wl-clipboard
    pkgs.slurp
    pkgs.grim
    (createScript "system-notification.sh")
    (createScript "screenshot.sh")
    (createScript "select-area-screenshot.sh")
    (createScript "screenshot-to-clipboard.sh")
    (createScript "select-area-screenshot-to-clipboard.sh")
  ];
in
{
  home.homeDirectory = "/home/${config.home.username}";

  home.packages = pkgs.callPackage ../../common/modules/packages.nix {} ++ extraPackages;

  wayland.windowManager.hyprland = import ./programs/hyprland/default.nix {inherit config;};

  
}
