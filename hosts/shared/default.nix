{ pkgs, inputs, outputs, overlays, lib, ... }:
let 
    material-symbols = pkgs.callPackage ../../pkgs/material-symbols.nix {};

    my-python-packages = ps: with ps; [
    matplotlib
  ];

in
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
        inputs.neovim-nightly-overlay.overlay

    })
  ];

   # bluetooth pipewire
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  # Enable
  sound.enable = true; 
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.polkit.enable = true;
  # xdg.portal.wlr.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };    
    dbus.enable = true;
    gnome.at-spi2-core.enable = true;
    gnome.gnome-keyring.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
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
      font-awesome
      roboto
      inter
      lato
      maple-mono
      maple-mono-NF
      material-symbols
      material-design-icons
      rubik
      ibm-plex
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      twemoji-color-font
      nerdfonts
      twemoji-color-font
      # (nerdfonts.override { fonts = [ "Iosevka" "CascadiaCode" "JetBrainsMono" "Mononoki" "Monofur" "IBMPlexMono" "Hack" ]; })
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
        emoji = [ "twemoji-color-font" ];
        monospace = [ "Mononoki" ];
        sansSerif = [ "rubik" "Noto Color Emoji" ];
        serif = [ "Noto Serif" "Noto Color Emoji" ];
      };
    };
  };

  environment.systemPackages =  with pkgs; [
    (pkgs.python311.withPackages my-python-packages)
    ####################
    killall
    playerctl
    swww
    wofi
    waybar
    ####################
    libsForQt5.qtwayland
    ####################
    pamixer
    ncmpcpp
    mpd
    ###################
    xorg.xwininfo
    libnotify
    xdg-utils
    jq
    xdotool
    rnix-lsp
    ripgrep
    xclip
    ###################
    xwallpaper
    gtk3
    dmenu
    st
    spotdl
    maim
    tldr
    vim
    steam
    lutris
    nix-prefetch-git
    git
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
    rofi-wayland
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

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  system = {
    stateVersion = "22.11";
  };
}
