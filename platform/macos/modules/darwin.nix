{
  inputs,
  pkgs,
  ...
}: {
  nubosa = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    inherit pkgs;

    modules = [
      ./configuration.nix
    ];
  };
}
