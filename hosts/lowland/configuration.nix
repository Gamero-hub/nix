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

 i18n = {
    defaultLocale = "ja_JP.UTF-8/UTF-8";
    # saves space
    supportedLocales = [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" ];
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
