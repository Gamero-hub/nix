{ config, pkgs, lib, ... }:
let
  # integrates nur within Home-Manager
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "sha256:16rmzn230nvagwhpby1xclix3mksv8893gjypg8acjd358imrry4";
  }) {inherit pkgs;};
  
  colors = import ./theme/colors.nix {};
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

  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
        octotree
      ];

  # Editor (nvim)
  systemd.user.sessionVariables.EDITOR = "nvim";

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
      (import ./programs/rofi.nix {inherit pkgs config lib;})
      (import ./programs/fish.nix {inherit pkgs;})
      (import ./programs/kitty)
      (import ./programs/firefox {inherit pkgs config colors extensions;})
      (import ./programs/bspwm {inherit pkgs;})
      (import ./programs/starship.nix)
      (import ./programs/git {inherit pkgs lib config;})
      (import ./programs/vscode {inherit pkgs config;})
      ];

}
