{ config, pkgs, ...}:
let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  spicetify-nix = (import flake-compat { src = builtins.fetchTarball "https://github.com/the-argus/spicetify-nix/archive/master.tar.gz"; }).defaultNix;
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin-mocha;
    colorScheme = "peach";
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      volumePercentage
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus    
    ];
  };
}