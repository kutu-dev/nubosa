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
    pavucontrol
    protonup
  ];

  extraScripts = [
    (createScript "system-notification.sh")
    (createScript "screenshot.sh")
    (createScript "select-area-screenshot.sh")
    (createScript "screenshot-to-clipboard.sh")
    (createScript "select-area-screenshot-to-clipboard.sh")
  ];
in {
  home.homeDirectory = "/home/${config.home.username}";

  home.packages = pkgs.callPackage ../../common/modules/packages.nix {} ++ extraPackages ++ extraScripts;

  wayland.windowManager.hyprland = import ./programs/hyprland/default.nix {inherit config;};

  services.udiskie.enable = true;

  programs.tofi = import ./programs/tofi.nix;

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/desktop/";
    documents = "${config.home.homeDirectory}/documents/";
    download = "${config.home.homeDirectory}/downloads/";
    music = "${config.home.homeDirectory}/music/";
    pictures = "${config.home.homeDirectory}/pictures/";
    publicShare = "${config.home.homeDirectory}/public/";
    templates = "${config.home.homeDirectory}/templates/";
    videos = "${config.home.homeDirectory}/videos/";
  };
  
  # Fix for profile not loading by default for being in a symlink
  # making Firefox crash
  xdg.desktopEntries.firefox-developer-edition = {
    name = "Firefox Developer Edition";
    genericName = "Web Browser";
    exec = "firefox-developer-edition --profile ${config.home.homeDirectory}/.mozilla/firefox/kutu/";
    terminal = false;
    categories = ["Application" "Network" "WebBrowser"];
    mimeType = ["text/html" "text/xml"];
  };
}
