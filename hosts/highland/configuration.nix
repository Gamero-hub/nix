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
      layout = "us";
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
  console.keyMap = "us";

  # DWM
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        src = /home/pablo/.config/suckless/dwm;
        buildInputs = (old.buildInputs or []) ++ [pkgs.harfbuzz];
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.pkg-config];
      });
      st = prev.st.overrideAttrs (old: {
        src = /home/pablo/.config/suckless/st;
        buildInputs = (old.buildInputs or []) ++ [pkgs.harfbuzz pkgs.xorg.libX11 pkgs.xorg.libXft pkgs.gd pkgs.glib];
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.pkg-config pkgs.ncurses pkgs.fontconfig pkgs.freetype];
      });
	dmenu = prev.st.overrideAttrs (old: {
        	src = /home/pablo/.config/suckless/dmenu;
        	buildInputs = (old.buildInputs or []) ++ [pkgs.harfbuzz pkgs.xorg.libX11 pkgs.xorg.libXft pkgs.gd pkgs.glib pkgs.xorg.libXinerama];
        	nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.pkg-config pkgs.ncurses pkgs.fontconfig pkgs.freetype ];
      });

	awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;

    })
  ];

  # Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;


}
