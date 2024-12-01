# NixOS Configurations
Personal NixOS configs, you may find this useful as a reference. Currently uses flakes and agenix, might expand into using Home Manager and/or NixOps.

## Systems
- **HydraValley** (Unused): 7840hs mini-pc, docker host
- **HydraValley.bak** (Unused): 7840hs mini-pc, developement environment which uses the Plasma DE
- **JellyCoast** (Unused): LXC container, single purpose Jellyfin node
- **OrcaStrait**: LXC container, docker host
- **SalamanderGrotto** (Unused): LXC container, single purpose Jellyseer node
- **RaccoonRapids** (Unused): LXC container, single purpose Syncthing node

> Note: This repository contains no longer used configs, these may or may not still work, and were left in as reference material.

## Usage
Currently, I run `nixos-rebuild switch --flake github:baconfield/nixconfig#TargetHostname` to build and switch to a specific config. Whenever I make changes to the repo, `nix-store --gc` is run to clear the outdated flake.

### Updating flakes
First make sure your local nix config is setup to use the experimental feature.
In either `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`:
```conf
experimental-features = nix-command flakes
```
or on NixOS:
```Nix
{ pkgs, ... }: {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
```
After that, you can run `nix flake update` to update the `flake.lock` file.

### Modifying secrets
From within `secrets/`, you can configure keys using `secrets.nix`, and modify the secrets with the following commands:
```sh
# Modifying a secret
nix run github:ryantm/agenix -- -e {secret}.age
# Rekeying the secrets
nix run github:ryantm/agenix -- -r
```

### Proxmox template
Creating your own template might be the most friction-free route to getting NixOS containers on Proxmox. After creating a container with the template, I'd recommend configuring that with a bare minimum config and creating a new template from that. For more details, see [here](https://nixos.wiki/wiki/Proxmox_Virtual_Environment#LXC).

```sh
# Generate an LXC template to upload to a Proxmox server
nix run github:nix-community/nixos-generators -- --format proxmox-lxc
```

```nix
# Basic config
{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = "23.11"
}
```

### `command-not-found` unable to open database
As root:
```sh
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --update
```
