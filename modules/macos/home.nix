{
  config,
  pkgs,
  ...
}: let
  functions = import ../common/functions.nix {
    inherit config;
    inherit pkgs;
    scriptsPath = ../../scripts/macos;
  };

  extraPackages = [
    (functions.createScript "random-change-wallpaper.sh")
  ];
in {
  home.homeDirectory = "/Users/${config.home.username}";

  home.packages = pkgs.callPackage ../common/packages.nix {} ++ extraPackages;

  xdg.configFile = import ../common/config-files.nix {dotfilesSymlink = functions.dotfilesSymlink;};

  home.file."Library/LaunchAgents/dev.dobon.nubosa.random-change-wallpaper.plist".source = ../../dotfiles/launch-agents/dev.dobon.nubosa.random-change-wallpaper.plist;

  # Disable the creation of `.DS_Store` files on Network and USB mounted devices
  targets.darwin.defaults."com.apple.desktopservices".DSDontWriteNetworkStores = true;
  targets.darwin.defaults."com.apple.desktopservices".DSDontWriteUSBStores = true;
}
