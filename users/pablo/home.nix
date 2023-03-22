{ config, pkgs, lib, inputs, spicetify-nix, ... }:
let
  # integrates nur within Home-Manager
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "sha256:16rmzn230nvagwhpby1xclix3mksv8893gjypg8acjd358imrry4";
  }) {inherit pkgs;};

  decayce-gtk = with pkgs; callPackage ./programs/decayce-gtk.nix { };

  decay-color = import ./theme/decay.nix {};
  colors = import ./theme/everforest.nix {};
  base16-theme = import ./theme/base16.nix {};
in {
  home.username = "pablo";
  home.homeDirectory = "/home/pablo";


# Gtk Configuration
  gtk = {
    enable = true;
    theme.name = "Catppuccin-Orange-Dark";
    theme.package = pkgs.catppuccin-gtk;
    iconTheme = with pkgs; {
      name = "Papirus-Dark";
      package = papirus-icon-theme;
    };
  };
  # Editor (nvim)
  systemd.user.sessionVariables.EDITOR = "hx";

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
  xdg.configFile."BetterDiscord/themes".source = ./cfg/bd-themes;

  home.stateVersion = "22.11";

    home.packages = with pkgs; [ 
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/.bin"
  ];

  #theme.base16.colors = base16-theme;

  imports =
     [
#      (import ./programs/game.nix {inherit pkgs config inputs;})
      (import ./programs/rofi {inherit pkgs config decay-color;})
      (import ./programs/fish.nix {inherit pkgs;})
      (import ./programs/cava {inherit colors;})
      (import ./programs/mpd {inherit config pkgs;})
      (import ./programs/ncmp {inherit config pkgs;})
      (import ./programs/kitty)
      (import ./programs/firefox {inherit pkgs config;})
      (import ./programs/bspwm {inherit pkgs;})
      (import ./programs/starship.nix)
      (import ./programs/git {inherit pkgs lib config;})
      (import ./programs/vscode {inherit pkgs config;})
      ];
}
