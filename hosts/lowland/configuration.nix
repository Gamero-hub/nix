{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../shared
    ];

    nixpkgs = {
/*    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      inputs.nixpkgs-f2k.overlays.stdenvs
    ];*/
    config = {
      # Disable if you don't want unfree packages
      allowUnfreePredicate = _: true;
      allowUnfree = true;
    };
  };
    
  networking.hostName = "lowland";  
  networking.networkmanager.enable = true;

  #Bootloader
  boot.kernelPackages = pkgs.linuxPackages_5_15;
  boot.loader = {
	systemd-boot.enable= true;
	efi.canTouchEfiVariables = true;
	efi.efiSysMountPoint = "/boot";
	systemd-boot.configurationLimit = 5;
	timeout = 1;
	};

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
   
  services = {
    xserver = {
        enable = true;
        layout = "es";
        displayManager.sddm.enable = true;
        windowManager.awesome.enable = true;
	      windowManager.bspwm.enable = true;
        windowManager.dwm.enable = true;
        desktopManager.plasma5.enable = true;
    };
  };

  # Configure console keymap
  console.keyMap = "es";

  # DWM
  nixpkgs.overlays = [
    (final: prev: 
      {
        dwm = prev.dwm.overrideAttrs (old: { src = /home/pablo/.config/suckless/dwm ;});
      })
  ];

}
