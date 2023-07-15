{ pkgs, outputs, overlays, lib, ... }:
let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  my-python-packages = ps: with ps; [
    numpy
  ];
in
{
  security = {
    sudo.enable = true;
  };

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
  };

  # enable starship inside bash interactive session (useful when using nix-shell).
  programs.bash.promptInit = ''
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';

  programs.zsh.enable = true;

  services = {
    devmon.enable = true;
    udisks2.enable = true;

    blueman.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Madrid";
  };
  users = {
    users.pablo = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
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
      material-design-icons
      rubik
      ibm-plex
      noto-fonts
      (nerdfonts.override { fonts = [ "Iosevka" "CascadiaCode" "JetBrainsMono" "Mononoki" "Monofur" "IBMPlexMono" ]; })
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "none";
      };

      subpixel.lcdfilter = "default";

      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Maple Mono NF" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        serif = [ "Noto Serif" "Noto Color Emoji" ];
      };
    };
  };

  sound.enable = true;

  environment.systemPackages = with pkgs; [
    pulseaudio
    ####################
    pamixer
    imagemagick
    ncmpcpp
    mpd
    mpdris2
    brightnessctl
    inotify-tools
    brillo
    networkmanager
    ###################
    xorg.xwininfo
    libnotify
    xdg-utils
    jq
    xdotool
    wmctrl
    slop
    rnix-lsp
    ripgrep
    xclip
    wirelesstools
    ###################
    gtk3
    st
    spotdl
    simplescreenrecorder
    nix-prefetch-git
    maim
    vim
    steam
    lutris
    nix-prefetch-git
    git
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
    zsh
    kitty
    rofi
    cava
    pcmanfm
    blueman
    bat
    discord
    htop
    tree
    lsd
    pywal
    font-manager
    slstatus
    feh
    htop
    pavucontrol
    jetbrains.pycharm-community
    neofetch
    xorg.xf86inputevdev
    xorg.xf86inputsynaptics
    xorg.xf86inputlibinput
    xorg.xorgserver
    xorg.xf86videoati

  ];

  environment.shells = with pkgs; [ zsh ];

  programs.dconf.enable = true;

  system = {
    stateVersion = "22.11";
  };
}
