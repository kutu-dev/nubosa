{
  config,
  pkgs,
  ...
}: let
  createScript = scriptName: pkgs.writeShellScriptBin (builtins.elemAt (pkgs.lib.strings.splitString "." scriptName) 0) (builtins.readFile (../../scripts + "/${scriptName}"));

  extraPackages = [
    (createScript "random-change-wallpaper.sh")
  ];
in {
  home.homeDirectory = "/Users/${config.home.username}";

  home.packages = pkgs.callPackage ../common/packages.nix {} ++ extraPackages;

  home.file."Library/LaunchAgents/dev.dobon.nubosa.random-change-wallpaper.plist".source = ../../dotfiles/launch-agents/dev.dobon.nubosa.random-change-wallpaper.plist;
}
