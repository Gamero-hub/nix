{ inputs, outputs, config, pkgs, lib, self, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.timeout = 1;

  hardware.opengl.driSupport32Bit = true;
  programs.steam.enable = true;

  #Networking
  networking.hostName = "highland";  

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enabling bluetooth
  hardware = {
    bluetooth.enable = true;
  };

  # Configure keymap in X11
  services = {
    xserver = {
    displayManager.gdm.wayland = false;
    layout = "us";
    xkbVariant = "";
    enable = true;
    windowManager.dwm.enable = true;
#    windowManager.bspwm.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "pablo";
   }; 

   # enables blueman for bluetooth
    blueman.enable = true;
 
   # automount usb
    devmon.enable = true;
    udisks2.enable = true;
 
};
  # Configure console keymap
  console.keyMap = "us";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Dconf
  programs.dconf.enable = true;

  # DWM
  nixpkgs.overlays = [
  #  outputs.overlays.modifications
  #  outputs.overlays.additions
  #  inputs.nixpkgs-f2k.overlays.stdenvs
    inputs.nixpkgs-f2k.overlays.compositors
    (final: prev: 
      {
        dwm = prev.dwm.overrideAttrs (old: { src = /home/pablo/.config/suckless/dwm ;});
      })
  ];

  # Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
   };  

  nixpkgs.config.allUnfree = true; 


}
