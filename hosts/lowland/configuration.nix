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
  i18n.defaultLocale = "ja_JP.UTF-8/UTF-8";
  supportedLocales = [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" ];

  i18n.extraLocaleSettings = {
    LC_ALL = "ja_JP.UTF-8/UTF-8";
    LC_ADDRESS = "ja_JP.UTF-8/UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8/UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8/UTF-8";
    LC_MONETARY = "ja_JP.UTF-8/UTF-8";
    LC_NAME = "ja_JP.UTF-8/UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8/UTF-8";
    LC_PAPER = "ja_JP.UTF-8/UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8/UTF-8";
    LC_TIME = "ja_JP.UTF-8/UTF-8";
  };

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
