{pkgs, ...}: let
  homePath = "/Users/kutu";
in {
  system.stateVersion = 5;

  services.nix-daemon.enable = true;
  users.users.kutu.home = homePath;

  # Ensure a non Nix dependent shell is set up as
  # the default one in case of breakage of the system
  users.users.kutu.shell = "/bin/bash";

  # `activateSettings -u` will reload the settings from the database
  # and apply them to the current session, so logout and login
  # to make the changes take effect is not necessary.
  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
      persistent-apps = [];
      persistent-others = [
        "${homePath}/Downloads/"
      ];

      # Disable all hot corners
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    finder.AppleShowAllExtensions = true;
    screencapture.location = "${homePath}/Pictures/Screenshots";
  };

  networking = let
    hostname = "epsilon";
  in {
    computerName = hostname;
    hostName = hostname;
    localHostName = hostname;
  };

  nix = {
    optimise.automatic = true;

    settings.trusted-users = [
      "kutu"
    ];

    gc = {
      automatic = true;

      # Every monday at 1:00 (AM)
      interval = {
        Hour = 1;
        Minute = 0;
        Weekday = 1;
      };

      options = "--delete-older-than 14d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes

      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };
}
