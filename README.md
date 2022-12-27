# NixOS Configurations
Personal NixOS configs, a learning project that might be useful as a reference. Currently testing out secret management with agenix, and planning to try out other projects like Home Manager and NixOps. Also planning to learn how things might be properly isolated and further hardened.

## Systems:
TortiseCove - A server primarily focused on file syncing and video streaming. Syncthing ran as user, and the backing store of content for a containerized Jellyfin service. Also uses ZFS. Plans: Check out what the consequences of moving syncthing into a container are, figure out network isolation, and configure wildcard certs and pass them to containers.

DoveTrail - Planned to be an extra node for Syncthing, however it has some services such as uptime-kuma and adguard-home in containers. Plans: The same points for TortiseCove, but might also get more services to monitor network/service health along with being the main system to replicate the data in syncthing to backblaze.

RaccoonRapids - Staging environment for large changes, currently testing agenix configs, but in the future Home Manager/NixOps
