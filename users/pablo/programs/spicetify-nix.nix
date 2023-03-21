{
  config,
  pkgs,
  lib,
  spicetify-nix,
  ...
}:
 let
   spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
 in
{
  # import the flake's module for your system
  imports = [ spicetify-nix.homeManagerModule ];

  # Spicetify - this is currently giving an infinite recursion error
   programs.spicetify =
     {
       enable = true;
       theme = spicePkgs.themes.catppuccin-mocha;
       colorScheme = "flamingo";
       enabledExtensions = with spicePkgs.extensions; [
         fullAppDisplay
       ];
     };
}