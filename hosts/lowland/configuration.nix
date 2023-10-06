{ config, pkgs, outputs, inputs, lib, self, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../shared
#      ../../home/pablo/services/swaywm.nix
      ../../home/pablo/home-manager/sway
    ];

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfreePredicate = _: true;
      allowUnfree = true;
      permittedInsecurePackages = [
        "nodejs-16.20.1" # until we upgrade our node.js version in .nvmrc
        "openssl-1.1.1u"
       ];
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];
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
  i18n.defaultLocale = "en_US.UTF-8";
  # i18n.defaultLocale = "ja_JP.UTF-8";
  # i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "en_US.UTF-8" ];

  # i18n.extraLocaleSettings = {
  #  LC_ALL = "en_US.UTF-8";
  #  LC_ADDRESS = "en_US.UTF-8";
  #  LC_IDENTIFICATION = "en_US.UTF-8";
  #  LC_MEASUREMENT = "en_US.UTF-8";
  #  LC_MONETARY = "en_US.UTF-8";
  #  LC_NAME = "en_US.UTF-8";
  #  LC_NUMERIC = "en_US.UTF-8";
  #  LC_PAPER = "en_US.UTF-8";
  #  LC_TELEPHONE = "en_US.UTF-8";
  #  LC_TIME = "en_US.UTF-8";
  # };

  services = {
    xserver = {
      enable = true;
      layout = "es";
      displayManager = {
          lightdm.enable = true;
          defaultSession = "hyprland";
          autoLogin.user = "pablo";
      };
      windowManager.awesome = {
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

}
