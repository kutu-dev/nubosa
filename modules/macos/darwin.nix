{inputs, ...}: {
  nubosa = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    pkgs = import inputs.nixpkgs {
      system = "aarch64-darwin";
      overlays = [
        inputs.nixpkgs-firefox-darwin.overlay
        inputs.nur.overlay
      ];
      config.allowUnfree = true;
    };

    modules = [
      {
        services.nix-daemon.enable = true;
        users.users.kutu.home = "/Users/kutu";

        # Ensure a non Nix related shell is set up as
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

            # Disable the quick note on the bottom right
            # hot corner.
            wvous-br-corner = 1;
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

      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.kutu.imports = [
          ./home.nix
          inputs.mac-app-util.homeManagerModules.default
          ../common/home.nix
        ];
      }
    ];
  };
}
