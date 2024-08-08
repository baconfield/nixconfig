# NixOS Configurations
Personal NixOS configs, you may find this useful as a reference. Currently makes use flakes and agenix, might expand into using Home Manager or NixOps.

## Systems:
TortiseCove - Primary server which hosts Nextcloud, Jellyfin, and Syncthing services. Makes use of ZFS for data integrety, whereas Nginx and acme are configured around DNS-01 based challenges for the local certs.

TanukiGrove - Tiny server currently used as a syncthing node, storage backed by BTRFS.

DoveTrail - Tiny server hosting services such as uptime-kuma and adguard-home. It also serves as another Syncthing node for redundancy. Planned to host more monitoring and health checks of the network.

RaccoonRapids - Staging VM for bigger changes, sees very little use currently.

## Usage
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
While in `secrets/`, running `nix run github:ryantm/agenix -- -e {secret}.age` will allow you to modify the contents of the secret
