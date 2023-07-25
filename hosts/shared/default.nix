{ pkgs, inputs, outputs, overlays, lib, ... }:
let 
    material-symbols = pkgs.callPackage ../../pkgs/material-symbols.nix {};
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

    })
  ];

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
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <!-- Default system-ui fonts -->
          <match target="pattern">
            <test name="family">
              <string>system-ui</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>sans-serif</string>
            </edit>
          </match>

          <!-- Default sans-serif fonts-->
          <match target="pattern">
            <test name="family">
              <string>sans-serif</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans CJK SC</string>
              <string>Noto Sans</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <!-- Default serif fonts-->
          <match target="pattern">
            <test name="family">
              <string>serif</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Serif CJK SC</string>
              <string>Noto Serif</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <!-- Default monospace fonts-->
          <match target="pattern">
            <test name="family">
              <string>monospace</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans Mono CJK SC</string>
              <string>Symbols Nerd Font</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-HK</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK HK</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-HK</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <!-- not have HK -->
              <string>Noto Serif CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-HK</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK HK</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-TW</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-TW</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Serif CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-TW</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ja</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK JP</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
                <string>ja</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Serif CJK JP</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ja</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK JP</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ko</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK KR</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ko</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Serif CJK KR</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ko</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK KR</string>
            </edit>
          </match>

          <!-- Replace monospace fonts -->
          <match target="pattern">
            <test name="family" compare="contains">
              <string>Source Code</string>
            </test>
            <edit name="family" binding="strong">
              <string>Iosevka Term</string>
            </edit>
          </match>
          <match target="pattern">
            <test name="lang" compare="contains">
              <string>en</string>
            </test>
            <test name="family" compare="contains">
              <string>Noto Sans CJK</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang" compare="contains">
              <string>en</string>
            </test>
            <test name="family" compare="contains">
              <string>Noto Serif CJK</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Serif</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };
    /*fontconfig = {
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
    };*/
#  };

  environment.systemPackages =  with pkgs; [
    python311
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

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  system = {
    stateVersion = "22.11";
  };
}
