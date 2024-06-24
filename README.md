<div align="center">
<img src="./header.jpg" width="275">
<h1>Nubosa</h1>

Ergonomic, pragmatical dotfiles and scripts for personal usage powered by [Nix](https://nixos.org/) available on both NixOS and macOS.
</div>

## Usage
### Prerequisites
- Have the [`nix`](https://nixos.org/download/) package manager installed (builtin with NixOS).

### Steps
First make available the [`just`](https://just.systems/man/en/) and [`git`](https://git-scm.com/) for the current terminal session
```sh
nix-shell -p just -p git
```

It is expected the dotfiles to be located at `$HOME/documents/dev/nubosa`, so set it up there:
```sh
mkdir -p $HOME/documents/dev/nubosa
git clone git@github.com:kutu-dev/nubosa.git
```

Then bootstrap your nix config to allow the usage of `flake`s and the new `nix` command:
```sh
just setup
```
Finally you just need to chose a host and apply it!  
There are two different available hosts `valhalla`, a desktop PC with NixOS, and `nirvana`, a MacBook Air M2 with [nix-darwin](https://daiderd.com/nix-darwin/), select the one that matches your needs and follow this steps:

#### For `valhalla` (NixOS only)
First set your own `hardware-configuration.nix`:
```sh
nixos-generate-config
cp /etc/nixos/hardware-configuration
```

And apply the config:
```sh
sudo hostnamectl set-hostname valhalla
just switch
```

#### For `nirvana` (macOS only)
Just apply the config and let it run:
```sh
sudo scutil --set HostName nirvana
just switch
```

### The `cumulus` CLI
Nubosa bundles a Python package destinated for theme and wallpaper management at the [`cumulus`](./cumulus) directory of the repository. It reads themes defined at [`dotfiles/cumulus`](./dotfiles/cumulus) and applies them all over the system, you can:

List all the defined themes:
```sh
cumulus theme list
```

Apply a theme:
```sh
cumulus theme apply oxocarbon
```

Randomly set a wallpaper that matches the aesthetics of the theme:
```sh
cumulus wallpaper set
```

This wallpaper is extracted from a pool located at: `$HOME/pictures/wallpapers/<theme-name>`.

### Personal notes
Imperative configurations that are not generic and may (and probably) need manual adjustment:

#### Steam (`valhalla` host only)
1. Activate compatibility for all titles.
2. Set `GE-Proton` as the default Proton runtime.
3. Add `/home/kutu/mounts/bravo` as default install point.

#### Syncthing
1. Enter the UI at: https://localhost:8384
2. Disallow anonymous Usage Reporting? No.
3. No set any password for the web GUI.
3. Remove default folder with `rm -r $HOME/Sync`.
4. Add the other devices.
5. Set up the following shared directories:
    - `$HOME/documents/dev`
    - `$HOME/pictures/wallpapers`
    - `$HOME/documents/aorta`
