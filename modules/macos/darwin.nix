{
  inputs,
  pkgs,
  ...
}: {
  nirvana = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    inherit pkgs;

    modules = [
      ./configuration.nix
    ];
  };
}
