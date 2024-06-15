{
  services.nix-daemon.enable = true;
  users.users.kutu.home = "/Users/kutu";

  # Ensure a non Nix dependent shell is set up as
  # the default one in case of breakage of the system
  users.users.kutu.shell = "/bin/bash";

  # activateSettings -u will reload the settings from the database
  # and apply them to the current session, so logout and login
  # to make the changes take effect is not necessary.
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
        "/Users/kutu/Downloads/"
      ];

      # Disable all hot corners
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    finder.AppleShowAllExtensions = true;
    screencapture.location = "/tmp";
  };

  networking = let
    hostname = "nirvana";
  in {
    computerName = hostname;
    hostName = hostname;
    localHostName = hostname;
  };
}
