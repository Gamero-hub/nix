{ inputs, spicetify-nix, ... }: {
  # themable spotify
  programs.spicetify =
    let
      spicePkgs = spicetify-nix;
    in
    {
      enable = true;

      theme = spicePkgs.themes.catppuccin-mocha;

      colorScheme = "flamingo";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        hidePodcasts
        shuffle
      ];
    };
}
