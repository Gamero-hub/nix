{ config, pkgs, lib, inputs, ... }:
let
  google-dot-cursor = pkgs.callPackage ../../pkgs/google-dot-cursor.nix {};
  spicetify-nix = inputs.spicetify-nix;
  nixpkgs-f2k = inputs.nixpkgs-f2k;

  dank = with pkgs; callPackage ../../pkgs/dank-mono.nix { };

  colors = import  ./theme/colors.nix { };
  theme = import ./theme/theme.nix { };
  wave = import ./theme/wave.nix { };
  base16-theme = import ./theme/base16.nix { };
in
{
  programs.obs-studio.enable = true;
  programs.kitty.enable = true;
  home.file.".icons/default".source = "${google-dot-cursor}/share/icons/GoogleDot-Black";

  home.username = "pablo";
  home.homeDirectory = "/home/pablo";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = true;
#         config = rec {
 #     modifier = "Mod4";
       # Use kitty as default terminal
  #    terminal = "kitty"; 
 #    startup = [
        # Launch Firefox on start
   #     {command = "firefox";}
    #  ];
 #   };
  };


  # Gtk Configuration
  gtk = {
    enable = true;

    font = {
      name = "Dank Mono";
      size = 12;
    };

    cursorTheme = {
      name = "GoogleDot-Black";
      package = google-dot-cursor;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Catppuccin-Mocha-Compact-Peach-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "peach" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };
  };

  imports =
    [
      (import ./programs/ro { inherit lib pkgs; })
      (import ./programs/spicetify/default.nix { inherit wave spicetify-nix pkgs; })
      (import ./programs/kitty/kitty.nix { inherit config pkgs; })
      (import ./programs/firefox { inherit pkgs config theme; })
      (import ./programs/bspwm { inherit pkgs; })
      (import ./programs/zsh/default.nix { inherit config pkgs; })
      (import ./programs/vscode { inherit pkgs config; })
      (import ./setup/hyprland {inherit pkgs;})
      (import ./scripts {inherit config lib pkgs;})
      (import ./programs/mako { inherit config pkgs; })
      (import ./programs/fish { inherit lib pkgs; })
      (import ./programs/mpv { inherit lib pkgs; })
      (import ./programs/helix { inherit inputs pkgs lib; })
      (import ./programs/neofetch {inherit config lib pkgs; })
      (import ./programs/sway {inherit config pkgs; })
    ];
  home = {
    activation = {
      installConfig = ''
        if [ ! -d "${config.home.homeDirectory}/.config/awesome" ]; then
          ${pkgs.git}/bin/git clone --depth 1 --branch the-awesome-config https://github.com/chadcat7/crystal ${config.home.homeDirectory}/.config/awesome
        fi
        if [ ! -d "${config.home.homeDirectory}/wallpapers" ]; then
          ${pkgs.git}/bin/git clone https://github.com/gamero-hub/wallpapers ${config.home.homeDirectory}/wallpapers
        fi
      '';
    };
  };

  # bat (cat clone)
  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      style = "plain";
      theme = "Monokai Extended";
    };
  };

  # link betterdiscord config
  #  xdg.configFile."BetterDiscord/themes".source = ./cfg/bd-themes;

  home.packages = with pkgs; [
    direnv
    dank
  ];
  
  xdg.configFile."direnv/direnvrc".text = ''
    source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
  '';

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
  };

  home.file = {
#	".config/helix".source = ./cfg/helix;
	".bin".source = ./cfg/bin;
  };
   
  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
  };
    # headset buttons
  systemd.user.services.mpris-proxy = {
    Unit.Description = "Mpris proxy";
    Unit.After = ["network.target" "sound.target"];
    Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    Install.WantedBy = ["default.target"];
  };
  
   # add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

}
