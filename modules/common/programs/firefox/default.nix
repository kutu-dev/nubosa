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
        tokyo-night-v2
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
            background-color: oklch(22.57% 0.019 280.25) !important;
          }

          .search-inner-wrapper {
            --newtab-background-color-secondary: oklch(24.86% 0.025 281.01);
          }
        }
      '';
    };
  };
}
