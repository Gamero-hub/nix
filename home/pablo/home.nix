{ config, pkgs, lib, inputs, ... }:
let
  google-dot-cursor = pkgs.callPackage ../../pkgs/google-dot-cursor.nix {};
  spicetify-nix = inputs.spicetify-nix;
  nixpkgs-f2k = inputs.nixpkgs-f2k;

  dank = with pkgs; callPackage ../../pkgs/dank-mono.nix { };

  # integrates nur within Home-Manager
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "08r5hk5lp88h0r4167w5cq8dqnjv892ygs9g3sw9y1dhdbf8pyln";
  }); 

  colors = import  ./theme/colors.nix { };
  theme = import ./theme/theme.nix { };
  wave = import ./theme/wave.nix { };
  base16-theme = import ./theme/base16.nix { };

in
{
  home.file.".icons/default".source = "${google-dot-cursor}/share/icons/GoogleDot-Black";

  home.username = "pablo";
  home.homeDirectory = "/home/pablo";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

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
      name = "Catppuccin-Mocha-Compact-Mauve-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        variant = "mocha";
      };
    };
  };

  imports =
    [
      (import ./programs/firefox {inherit pkgs config nur colors;})  
      (import ./programs/rof/default.nix { inherit config pkgs wave; })
      (import ./programs/spicetify/default.nix { inherit wave spicetify-nix pkgs; })
      (import ./programs/kitty { inherit colors pkgs; })
      (import ./programs/firefox { inherit pkgs config theme; })
      (import ./programs/bspwm { inherit pkgs; })
      (import ./programs/zsh/default.nix { inherit config pkgs; })
      (import ./programs/vscode { inherit pkgs config; })
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
    dank
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
  };

  home.file = {
	".config/helix".source = ./cfg/helix;
	".bin".source = ./cfg/bin;
  };
   
   # add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
 
}
