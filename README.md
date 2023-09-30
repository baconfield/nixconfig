# NixOS Configurations
Personal NixOS configs, you may find this useful as a reference. Currently uses flakes and agenix, might expand into using Home Manager and/or NixOps.


## Systems

**JellyCoast** - An LXC container, single purpose Jellyfin node
**RaccoonRapids** - An LXC container, single purpose Syncthing node

#### Unused configs
You likely will see a few unused system/service configs in this repo that were left in as a reference. These should still function, however they have not been tested in some time.

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

  system.stateVersion = "23.11";
}
```
