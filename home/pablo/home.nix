{ config, pkgs, lib, inputs, ... }:
let
  spicetify-nix = inputs.spicetify-nix;
  nixpkgs-f2k = inputs.nixpkgs-f2k;

  dank = with pkgs; callPackage ../../pkgs/dank-mono.nix {};

  theme = import ./theme/theme.nix{};
  colors = import ./theme/arctic.nix {};
  wave = import ./theme/wave.nix{};
  base16-theme = import ./theme/base16.nix {};

in {

  home.username = "pablo";
  home.homeDirectory = "/home/pablo";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  home.file.".icons/default".source = 
    "${pkgs.phinger-cursors}/share/icons/phinger-cursors"; 

# Gtk Configuration
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    cursorTheme.name = "Phinger-cursors";
    cursorTheme.package = pkgs.phinger-cursors;
    theme.name = "Catppuccin-Orange-Dark";
    theme.package = pkgs.catppuccin-gtk;
    iconTheme = with pkgs; {
      name = "Papirus-Dark";
      package = papirus-icon-theme;
    };
  };


imports =
     [
#      (import ./programs/game.nix {inherit pkgs config inputs;})
#      (import ./programs/fish.nix {inherit pkgs;})
#      (import ./programs/starship.nix)
#      (import ./programs/nvim {inherit pkgs;})
      (import ./programs/rof/default.nix { inherit config pkgs wave; })
      (import ./programs/spicetify/default.nix { inherit wave spicetify-nix pkgs; })
      (import ./programs/kitty)
      (import ./programs/firefox {inherit pkgs config theme;})
      (import ./programs/bspwm {inherit pkgs;})
      (import ./programs/zsh/default.nix { inherit config pkgs; })
      (import ./programs/git {inherit pkgs lib config;})
      (import ./programs/vscode {inherit pkgs config;})
      (import ./programs/neofetch {inherit config colors;})
      ];

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
}
