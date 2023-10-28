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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  environment.systemPackages = with pkgs; [
    inxi
    blender-hip
    bottom
    btop
    curl
    fishPlugins.tide
    firefox
    git
    kate
    micro
    nano
    neofetch
    wget
    vim
  ];

  system.stateVersion = "23.05";

}
