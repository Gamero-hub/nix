{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config = 
{
    # Allow proprietary packages
    allowUnfree = true;

    # Create an alias for the unstable channel
    packageOverrides = pkgs: 
    {
        unstable = import <nixos-unstable> 
            { 
                # pass the nixpkgs config to the unstable alias
                # to ensure `allowUnfree = true;` is propagated:
                config = config.nixpkgs.config; 
            };
    };
}

  #Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.timeout  = 1;

  #Networking
  networking.hostName = "virtland";  

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
   
  # Pipewire
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
      };
    };

  # Enabling bluetooth
  hardware = {
    bluetooth.enable = true;
  };


  # enable starship inside bash interactive session (useful when using nix-shell).
  programs.bash.promptInit = ''
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';


  # Configure keymap in X11
  services = {
    xserver = {
    layout = "us";
    xkbVariant = "";
    enable = true;
    windowManager.dwm.enable = true;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pablo = {
    isNormalUser = true;
    description = "pablo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users = {
  defaultUserShell = pkgs.fish;};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Dconf
  programs.dconf.enable = true;

  # Dwm
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/pablo/.config/suckless/dwm ;});
      })
  ];

  # enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
   };  

  nixpkgs.config.allUnfree = true; 

  system.stateVersion = "22.11";

  # fontconfig configuration
  fonts = {
    fonts = with pkgs; [
      inter
      lato
      maple-mono
      maple-mono-NF
      noto-fonts
      (nerdfonts.override { fonts = [ "Iosevka" "CascadiaCode" "JetBrainsMono" ]; })
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };

      subpixel.lcdfilter = "default";

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["Maple Mono NF"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
      };
    };
  };
}
