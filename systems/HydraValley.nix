{ config, pkgs, ... }:

{
  networking.hostName = "HydraValley";
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    # X11 keymap
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    inxi
    blender
    bottom
    btop
    curl
    fishPlugins.tide
    firefox
    git
    godot
    kate
    krita
    micro
    nano
    neofetch
    podman-compose
    python312
    wget
    vim
  ];

  virtualisation.podman.enable = true;
  virtualisation.podman.defaultNetwork.settings.dns_enabled = true;

  system.stateVersion = "23.05";
}