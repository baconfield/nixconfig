# NixOS Configurations
Personal NixOS configs, you may find this useful as a reference. Currently makes use flakes and agenix, might expand into using Home Manager or NixOps.

## Systems:
BaconField - Nextcloud VM

TortiseCove - Config no longer in use, primary role is to host Nextcloud, Jellyfin, and Syncthing services. Makes use of ZFS for data integrety, whereas Nginx and acme are configured around DNS-01 based challenges for the local certs.

TanukiGrove - Config no longer in use, primary role of being a syncthing node.

DoveTrail - Config no longer in use, primary role is to host services such as uptime-kuma, adguard-home, and Syncthing.

RaccoonRapids - Staging VM for bigger changes, sees very little use currently.

## Usage
Currently this whole repo is cloned into `/etc/nixos/`, I might add scripts or shell commands to keep it in a more sane place. Any recommendations will be happily taken.
Alternatively, you can run `nixos-rebuild switch --flake github:baconfield/nixconfig#TanukiGrove` to build and switch to the TanukiGrove config.

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
While in `secrets/`, running `nix run github:ryantm/agenix -- -e {secret}.age` will allow you to modify the contents of the secret, whereas `nix run github:ryantm/agenix -- -r` will rekey them.
