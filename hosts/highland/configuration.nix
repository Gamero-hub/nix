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

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;


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
  systemd.user.services."urxvtd" = {
    enable = true;
    description = "rxvt unicode daemon";
    wantedBy = [ "default.target" ];
    path = [ pkgs.rxvt_unicode ];
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.rxvt_unicode}/bin/urxvtd -q -o";
  };

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
        displayManager.sessionCommands =  ''
       xrdb "${pkgs.writeText  "xrdb.conf" ''
          URxvt.font:                 xft:Dejavu Sans Mono for Powerline:size=11
          XTerm*faceName:             xft:Dejavu Sans Mono for Powerline:size=11
          XTerm*utf8:                 2
          URxvt.iconFile:             /usr/share/icons/elementary/apps/24/terminal.svg
          URxvt.letterSpace:          0
          URxvt.background:           #121214
          URxvt.foreground:           #FFFFFF
          XTerm*background:           #121212
          XTerm*foreground:           #FFFFFF
          ! black
          URxvt.color0  :             #2E3436
          URxvt.color8  :             #555753
          XTerm*color0  :             #2E3436
          XTerm*color8  :             #555753
          ! red
          URxvt.color1  :             #CC0000
          URxvt.color9  :             #EF2929
          XTerm*color1  :             #CC0000
          XTerm*color9  :             #EF2929
          ! green
          URxvt.color2  :             #4E9A06
          URxvt.color10 :             #8AE234
          XTerm*color2  :             #4E9A06
          XTerm*color10 :             #8AE234
          ! yellow
          URxvt.color3  :             #C4A000
          URxvt.color11 :             #FCE94F
          XTerm*color3  :             #C4A000
          XTerm*color11 :             #FCE94F
          ! blue
          URxvt.color4  :             #3465A4
          URxvt.color12 :             #729FCF
          XTerm*color4  :             #3465A4
          XTerm*color12 :             #729FCF
          ! magenta
          URxvt.color5  :             #75507B
          URxvt.color13 :             #AD7FA8
          XTerm*color5  :             #75507B
          XTerm*color13 :             #AD7FA8
          ! cyan
          URxvt.color6  :             #06989A
          URxvt.color14 :             #34E2E2
          XTerm*color6  :             #06989A
          XTerm*color14 :             #34E2E2
          ! white
          URxvt.color7  :             #D3D7CF
          URxvt.color15 :             #EEEEEC
          XTerm*color7  :             #D3D7CF
          XTerm*color15 :             #EEEEEC
          URxvt*saveLines:            32767
          XTerm*saveLines:            32767
          URxvt.colorUL:              #AED210
          URxvt.perl-ext:             default,url-select
          URxvt.keysym.M-u:           perl:url-select:select_next
          URxvt.url-select.launcher:  /usr/bin/firefox -new-tab
          URxvt.url-select.underline: true
          Xft*dpi:                    96
          Xft*antialias:              true
          Xft*hinting:                full
          URxvt.scrollBar:            false
          URxvt*scrollTtyKeypress:    true
          URxvt*scrollTtyOutput:      false
          URxvt*scrollWithBuffer:     false
          URxvt*scrollstyle:          plain
          URxvt*secondaryScroll:      true
          Xft.autohint: 0
          Xft.lcdfilter:  lcddefault
          Xft.hintstyle:  hintfull
          Xft.hinting: 1
          Xft.antialias: 1 
       ''}"
    '';
      displayManager = {
          sddm.enable = true;
          defaultSession = "none+i3";
          #defaultSession = "hyprland";
          #autoLogin.user = "pablo";
      };

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
