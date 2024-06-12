{
  config,
  pkgs,
  ...
}: let
  createScript = scriptName: pkgs.writeShellScriptBin (builtins.elemAt (pkgs.lib.strings.splitString "." scriptName) 0) (builtins.readFile (../scripts + "/${scriptName}"));

  extraPackages = [
    (createScript "random-change-wallpaper.sh")
  ];
in {
  home.homeDirectory = "/Users/${config.home.username}";

  home.packages = pkgs.callPackage ../../common/modules/packages.nix {} ++ extraPackages;

  home.file."Library/LaunchAgents/dev.dobon.nubosa.random-change-wallpaper.plist".source = ../dotfiles/launch-agents/dev.dobon.nubosa.random-change-wallpaper.plist;

  # Disable the creation of `.DS_Store` files on Network and USB mounted devices
  targets.darwin.defaults."com.apple.desktopservices".DSDontWriteNetworkStores = true;
  targets.darwin.defaults."com.apple.desktopservices".DSDontWriteUSBStores = true;
}
