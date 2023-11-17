{ config, pkgs, outputs, inputs, lib, self, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../shared
      ../../home/pablo/setup/sway/swaywm.nix
    ];

  /*  programs.waybar = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
      settings = waybar_config;
      style = waybar_style;
    }*/

#  programs.sway = {
#    enable = true;
#    wrapperFeatures.gtk = true;
#  };

  programs.hyprland = {
    enableNvidiaPatches = true;
    xwayland = {
      enable = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfreePredicate = _: true;
      allowUnfree = true;
    };
  };

  networking.hostName = "highland";
  networking.networkmanager.enable = true;

  #Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.configurationLimit = 5;

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
      layout = "us";
      displayManager = {
          sddm.enable = true;
          defaultSession = "none+i3";
          #defaultSession = "hyprland";
          #autoLogin.user = "pablo";
      };
      desktopManager = {
        xterm.enable = false;
      }

      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
        ];
      };
      windowManager.bspwm.enable = true;
      windowManager.dwm.enable = true;
      windowManager.i3.enable = true;
    };
  };

  # Configure console keymap
  console.keyMap = "us";

  # Nvidia
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Tell Xorg to use the nvidia driver (also valid for Wayland)
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    modesetting.enable = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

}
