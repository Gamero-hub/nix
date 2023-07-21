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
        waybar = prev.waybar.overrideAttrs (oldAttrs: {
        	 mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        	 postPatch = (oldAttrs.postPatch or "") + ''
		    sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp'';
      });


        awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;

    })
  ];

  programs.hyprland.enable = true;
  xdg.portal.wlr.enable = true;
  services.dbus.enable = true;
  security.rtkit.enable = true;

  security = {
    sudo.enable = true;
    polkit.enable = true;
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

  services.gnome.gnome-keyring.enable = true;

  services.gnome.at-spi2-core.enable = true;

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
    swww
    wofi
    ####################
    gnome.seahorse
    haruna

    libsForQt5.dolphin
    libsForQt5.ark
    libsForQt5.gwenview
    libsForQt5.dolphin-plugins
    libsForQt5.ffmpegthumbs
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.kio
    libsForQt5.kio-extras
    libsForQt5.qtwayland
    libsForQt5.okular
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

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  system = {
    stateVersion = "22.11";
  };
}
