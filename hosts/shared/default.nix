{ pkgs, inputs, outputs, overlays, lib, ... }:
{ 
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        src = /home/pablo/.config/suckless/dwm;
        buildInputs = (old.buildInputs or []) ++ [pkgs.harfbuzz];
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.pkg-config];
      });
      st = prev.st.overrideAttrs (old: {
        src = /home/pablo/.config/suckless/st;
        buildInputs = (old.buildInputs or []) ++ [pkgs.harfbuzz pkgs.xorg.libX11 pkgs.xorg.libXft pkgs.gd pkgs.glib pkgs.git];
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.pkg-config pkgs.git];
      });
        dmenu = prev.st.overrideAttrs (old: {
                src = /home/pablo/.config/suckless/dmenu;
                buildInputs = (old.buildInputs or []) ++ [pkgs.harfbuzz pkgs.xorg.libX11 pkgs.xorg.libXft pkgs.gd pkgs.glib pkgs.xorg.libXinerama];
                nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.pkg-config pkgs.ncurses pkgs.fontconfig pkgs.freetype];
      });

        awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;

    })
  ];

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

  programs.zsh.enable = true;

  services = {
    devmon.enable = true;
    udisks2.enable = true;

    blueman.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
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

  environment.systemPackages = with pkgs; [
    python311
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
    xwallpaper
    gtk3
    dmenu
    st
    spotdl
    simplescreenrecorder
    maim
    tldr
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
