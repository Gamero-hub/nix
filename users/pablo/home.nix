{ config, pkgs, lib, inputs, spicetify-nix, ... }:
let
  spicetify-nix = inputs.spicetify-nix;
  decayce-gtk = with pkgs; callPackage ./programs/decayce-gtk.nix { };

  dank = with pkgs; callPackage ../../pkgs/dank-mono.nix {};

  theme = import ./theme/theme.nix{};
  decay-color = import ./theme/decay.nix {};
  colors = import ./theme/everforest.nix {};
  wave = import ./theme/wave.nix{};
  base16-theme = import ./theme/base16.nix {};

  unstable = import
    (builtins.fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz")
    {
      config = config.nixpkgs.config;
    };
in {
  home.username = "pablo";
  home.homeDirectory = "/home/pablo";

  home.file.".icons/default".source = 
    "${pkgs.phinger-cursors}/share/icons/phinger-cursors"; 

# Gtk Configuration
  gtk = {
    enable = true;
    cursorTheme.name = "Phinger-cursors";
    cursorTheme.package = pkgs.phinger-cursors;
    theme.name = "Catppuccin-Orange-Dark";
    theme.package = pkgs.catppuccin-gtk;
    iconTheme = with pkgs; {
      name = "Papirus-Dark";
      package = papirus-icon-theme;
    };
  };
  # Editor 
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
#  xdg.configFile."BetterDiscord/themes".source = ./cfg/bd-themes;
  

  home.stateVersion = "22.11";

    home.packages = with pkgs; [ 
    dank
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/.bin"
  ];

  imports =
     [
#      (import ./programs/game.nix {inherit pkgs config inputs;})
#      (import ./programs/fish.nix {inherit pkgs;})
#      (import ./programs/starship.nix)
      (import ./programs/rof/default.nix { inherit config pkgs wave; })
      (import ./programs/spicetify.nix { inherit wave spicetify-nix pkgs; })
      (import ./programs/cava {inherit colors;})
      (import ./programs/kitty)
      (import ./programs/firefox {inherit pkgs config theme;})
      (import ./programs/bspwm {inherit pkgs;})
      (import ./programs/zsh/default.nix { inherit config pkgs; })
      (import ./programs/git {inherit pkgs lib config;})
      (import ./programs/vscode {inherit pkgs config;})
      ];
}
