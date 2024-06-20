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

      userContent = import ./user-content.nix;

      userChrome = import ./user-chrome.nix;
      };
  };
}
