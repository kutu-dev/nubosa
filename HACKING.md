# Hacking
Here there are some useful notes about the system in case you want to tinker with it.

## Tooling
There is a recipe designed to run the linting and formatting of all the languages used on Nubosa, just run it like this:
```sh
just check
```

## File structure
The main directories that constitute Nubosa are:
- [`cumulus`](./cumulus): The custom CLI designed for Nubosa, its flake and justfile are tailored for this project and will only work on `nix` environment and not on generic [`venv`](https://docs.python.org/3/library/venv.html) Python one. 
- [`dotfiles`](./dotfiles): Dotfiles that are not declared with `nix` lang and are symlinked by Home Manager, here at [`dotfiles/nix/nix.conf`](./dotfiles/nix/nix.conf) is stored the nix config applied by `just setup`.
- [`justfiles`](./justfiles): Extra justfiles impored to the many one.
- [`modules`](./modules): Nix files used by the system split on [`modules/common`](./modules/common) for all hosts, [`modules/nixos`](./modules/nixos) for the `valhalla` host and [`modules/macos`](./modules/macos) for the `nirvana` host.
- [`scripts`](./scripts): Scripts installed on the `valhalla` host at [`scripts/nixos`](./scripts/nixos) and auxiliar scripts used for the tooling of the repository at [`scripts/misc`](./scripts/misc).
- [`static`](./static): Static files used by the Markdown files.

## Cumulus `flake.lock` issue
Unfortunately the support for using a flake relative to another in a repository is cumbersome to say at least, [and it doesn't seam to be improved in the near future](https://github.com/NixOS/nix/issues/3978), so the only solution at the moment is to add the flake as an import using the `path:` URL which have as a consequence the locking of its input dependant of the file system where the lock occurred to work around this the recipe `lock-cumulus` located at [`justfiles/misc.just`](./justfiles/misc.just) needs to be run on every new system, to make this transparent to the user this recipe is put as a dependency on every recipe that interacts with the main `flake.nix` file.
