{ pkgs, outputs, overlays, lib, ... }:
{
  security = {
    sudo.enable = true;
  };

   time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Madrid";
  };
  users = {
    users.pablo = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      packages = with pkgs; [ ];
    };
    defaultUserShell = pkgs.zsh;
  };
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
        monospace = ["Dank Mono"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
      };
    };
    };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  security.rtkit.enable = true;
  virtualisation = {
    libvirtd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gtk3
    st
    spotdl
    simplescreenrecorder
    nix-prefetch-git
    maim
    xorg.xf86inputevdev
    xorg.xf86inputsynaptics
    xorg.xf86inputlibinput
    xorg.xorgserver
    xorg.xf86videoati
    vim
    (python39.withPackages(ps: with ps; [ readchar pyttsx3 pyaudio pip ]))
    nix-prefetch-git
    picom
    nix-prefetch-github
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
#    fish
    unstable.zsh
    kitty
    rofi
    cava
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
    unstable.jetbrains.pycharm-community
    neofetch
  ];

  environment.shells = with pkgs; [ zsh ];

  programs.dconf.enable = true;

  system = {
    stateVersion = "22.11";
  };
}
