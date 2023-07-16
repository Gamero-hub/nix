{ config, pkgs, lib, inputs, ... }:
let
  spicetify-nix = inputs.spicetify-nix;
  nixpkgs-f2k = inputs.nixpkgs-f2k;

  dank = with pkgs; callPackage ../../pkgs/dank-mono.nix { };

  theme = import ./theme/theme.nix { };
  colors = import ./theme/arctic.nix { };
  wave = import ./theme/wave.nix { };
  base16-theme = import ./theme/base16.nix { };

in
{

  home.username = "pablo";
  home.homeDirectory = "/home/pablo";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  # Gtk Configuration

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 20;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "Roboto";
      package = pkgs.roboto;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

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
      #      (import ./programs/game.nix {inherit pkgs config inputs;})
      #      (import ./programs/fish.nix {inherit pkgs;})
      #      (import ./programs/starship.nix)
      #      (import ./programs/nvim {inherit pkgs nvim-flake;})
      (import ./programs/rof/default.nix { inherit config pkgs wave; })
      (import ./programs/spicetify/default.nix { inherit wave spicetify-nix pkgs; })
      (import ./programs/kitty { inherit colors pkgs; })
      (import ./programs/firefox { inherit pkgs config theme; })
      (import ./programs/bspwm { inherit pkgs; })
      (import ./programs/zsh/default.nix { inherit config pkgs; })
      (import ./programs/git { inherit pkgs lib config; })
      (import ./programs/vscode { inherit pkgs config; })
      (import ./programs/neofetch { inherit config colors; })
    ];
  home = {
    activation = {
      installConfig = ''
        if [ ! -d "${config.home.homeDirectory}/.config/awesome" ]; then
          ${pkgs.git}/bin/git clone --depth 1 --branch the-awesome-config https://github.com/chadcat7/crystal ${config.home.homeDirectory}/.config/awesome
        fi
	if [ ! -d "${config.home.homeDirectory}/.config/nvim" ]; then
          ${pkgs.git}/bin/git clone https://github.com/AlphaTechnolog/nvim ${config.home.homeDirectory}/.config/nvim
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
#	".config/dwm".source = ./cfg/dwm;
	".config/helix".source = ./cfg/helix;
	".bin".source = ./cfg/bin;
#	".dwm".source = ./cfg/autostart.sh;
  };

}
