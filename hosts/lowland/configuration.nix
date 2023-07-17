{ config, pkgs, outputs, inputs, lib, self, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../shared
    ];

  nixpkgs = {
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
    systemd-boot.enable = true;
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
      windowManager.awesome = {
        # Best window manager
        enable = true;
        luaModules = with pkgs.lua52Packages; [
          lgi
          ldbus
          luarocks-nix
          luadbi-mysql
          luaposix
        ];
      };
      windowManager.bspwm.enable = true;
      windowManager.dwm.enable = true;
    };
  };

  # Configure console keymap
  console.keyMap = "es";

  # DWM
  nixpkgs.overlays = [
    (final: prev:
      {
        awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
      })

    (final: prev:
      {
        dwm = prev.dwm.overrideAttrs (old: { src = /home/pablo/.config/suckless/dwm; });
      })
   (final: prev:
      {
   	st = prev.st.overrideAttrs (old: {
        	src = /home/xenoxanite/Suckless/st;
        	buildInputs = (old.buildInputs or []) ++ [pkgs.harfbuzz];
        	nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.pkg-config];
      }) 

  ];

}
