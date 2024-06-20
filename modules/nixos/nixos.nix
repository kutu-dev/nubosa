{
  inputs,
  pkgs,
  ...
}: {
  valhalla = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    inherit pkgs;

    modules = [
      ./configuration.nix
      ./hardware-configuration.nix
    ];
  };
}
