{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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


  environment.systemPackages = with pkgs; [
  python3
  unzip
  yt-dlp
  neovim
  firefox
  vscode-fhs
  starship
  mpv
  helix
  sxhkd
  feh
  fish
  kitty
  rofi
  cava
  jq
  pcmanfm
  blueman
  git
  bat
  discord
  htop
  tree
  lsd
  pywal
  font-manager
  slstatus
  gh
  feh 
  htop
  pavucontrol
  jetbrains.pycharm-community
  neofetch
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

  networking.extraHosts =
    builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/StevenBlack/hosts/e1bb5f08e6f9f4daef93cc327580a95f83959f38/alternates/fakenews-gambling/hosts";
      sha256 = "LZt3/AvsbYuW+TWsnGnRQNXhvGYO0tMc7uHY/A19bUc=";
      # blocks fakenews, gambling and coomer sites
    })
    + builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/shreyasminocha/shady-hosts/fc9cc4020e80b3f87024c96178cba0f766b95e7a/hosts";
      sha256 = "jbsEiIcOjoglqLeptHhwWhvL/p0PI3DVMdGCzSXFgNA=";
      # blocks some shady fed sites
    })
    + builtins.readFile (pkgs.fetchurl {
      # blocks crypto phishing scams
      url = "https://raw.githubusercontent.com/MetaMask/eth-phishing-detect/3be0b9594f0bc6e3e699ee30cb2e809618539597/src/hosts.txt";
      sha256 = "b3HvaLxnUJZOANUL/p+XPNvu9Aod9YLHYYtCZT5Lan0=";
    })
    + builtins.readFile (pkgs.fetchurl {
      # generic ads
      url = "https://raw.githubusercontent.com/AdAway/adaway.github.io/04f783e1d9f48bd9ac156610791d7f55d0f7d943/hosts.txt";
      sha256 = "mp0ka7T0H53rJ3f7yAep3ExXmY6ftpHpAcwWrRWzWYI=";
    });

}