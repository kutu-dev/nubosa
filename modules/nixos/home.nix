{
  config,
  pkgs,
  ...
}: let
  functions = import ../common/functions.nix {
    inherit config;
    inherit pkgs;
    scriptsPath = ../../scripts/nixos;
  };

  extraPackages = with pkgs; [
    wl-clipboard
    slurp
    grim
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    pavucontrol
    protonup
    mangohud
    prismlauncher
    hyprpicker
    swww
    xdg-utils
    qimgv
    sshfs
  ];

  extraScripts = [
    (functions.createScript "system-notification.sh")
    (functions.createScript "screenshot.sh")
    (functions.createScript "select-area-screenshot.sh")
    (functions.createScript "screenshot-to-clipboard.sh")
    (functions.createScript "select-area-screenshot-to-clipboard.sh")
  ];
in {
  home.homeDirectory = "/home/${config.home.username}";

  home.packages = pkgs.callPackage ../common/packages.nix {} ++ extraPackages ++ extraScripts;

  wayland.windowManager.hyprland = import ./programs/hyprland/default.nix {inherit config;};

  services.udiskie.enable = true;
  services.cliphist.enable = true;
  services.ssh-agent.enable = true;

  programs.tofi = import ./programs/tofi.nix;

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.ags.enable = true;

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  xdg.enable = true;

  xdg.configFile =
    {
      ags.source = functions.dotfilesSymlink "ags";
    }
    // import ../common/config-files.nix {
      dotfilesSymlink = functions.dotfilesSymlink;
      inherit pkgs;
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

  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox-developer-edition.desktop";
      "x-scheme-handler/http" = "firefox-developer-edition.desktop";
      "x-scheme-handler/https" = "firefox-developer-edition.desktop";
      "x-scheme-handler/about" = "firefox-developer-edition.desktop";
      "x-scheme-handler/unknown" = "firefox-developer-edition.desktop";

      "image/jpeg" = "qimgv.desktop";
      "image/png" = "qimgv.desktop";
    };
  };

  # Fix for profile not loading by default for being in a symlink
  # making Firefox crash
  xdg.desktopEntries.firefox-developer-edition = {
    name = "Firefox Developer Edition";
    genericName = "Web Browser";
    exec = "firefox-developer-edition --profile ${config.home.homeDirectory}/.mozilla/firefox/kutu/ %U";
    terminal = false;
    categories = ["Application" "Network" "WebBrowser"];
    mimeType = ["text/html" "text/xml"];
  };
}
