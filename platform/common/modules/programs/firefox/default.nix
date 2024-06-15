{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;

    profiles.kutu = {
      id = 0;
      name = "Kutu";
      isDefault = true;

      search = {
        default = "DuckDuckGo";
        force = true;
      };

      containersForce = true;
      containers.school = {
        id = 1;
        name = "School";
        color = "yellow";
        icon = "briefcase";
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        multi-account-containers
        ublock-origin
      ];

      bookmarks = [
        {
          name = "Toolbar";
          toolbar = true;
          bookmarks = import ./bookmarks.nix;
        }
      ];

      settings = import ./settings.nix;

      userContent = ''
        @-moz-document url(about:home), url(about:newtab) {
          body {
            background-color: oklch(20.02% 0 0) !important;
          }

          .search-inner-wrapper {
            --newtab-background-color-secondary: oklch(34.46% 0 0) !important;
          }
        }
      '';

      userChrome = ''
        #TabsToolbar {
          --lwt-tab-line-color: #00000000 !important;
        }

        #nav-bar {
          border-top: none !important;
        }

        #navigator-toolbox {
          border-bottom: none !important;
        }

        .titlebar-buttonbox-container {
          display: none !important;
        }

        #tabbrowser-tabs {
          border-inline-start: none !important;
        }

        .titlebar-spacer {
          width: 0 !important;
        }
      '';
    };
  };
}
