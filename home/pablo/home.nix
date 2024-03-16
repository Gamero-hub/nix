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
  programs.kitty.enable = true;
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
      # (import ./programs/rofi { inherit lib pkgs; })
      (import ./programs/spicetify/default.nix { inherit wave spicetify-nix pkgs; })
      (import ./programs/kitty/kitty.nix { inherit config pkgs; })
      # (import ./programs/firefox { inherit pkgs config theme; })
      (import ./programs/bspwm { inherit pkgs; })
      (import ./programs/zsh/default.nix { inherit config pkgs; })
      (import ./programs/vscode { inherit pkgs config; })
      (import ./setup/hyprland {inherit pkgs;})
      (import ./scripts {inherit config lib pkgs;})
      (import ./programs/mako { inherit config pkgs; })
      (import ./programs/fish { inherit lib pkgs; })
    ];
  home = {
    activation = {
      installConfig = ''
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

  # xdg.configFile."waybar/".source = ./cfg/waybar;

  home.packages = with pkgs; [
    direnv
    dank
  ];
  

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    allowUnfreePredicate = _: true;
  };

  home.file = {
#	".config/helix".source = ./cfg/helix;
	".bin".source = ./cfg/bin;
    # ".config/waybar".source = ./cfg/waybar;
  };
   
  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
  };
  
   # add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

}
