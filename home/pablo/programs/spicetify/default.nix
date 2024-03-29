{wave, spicetify-nix,  pkgs, ...}:
let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  spicetify-nix = (import flake-compat { src = builtins.fetchTarball "https://github.com/the-argus/spicetify-nix/archive/master.tar.gz"; }).defaultNix;
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
  

  officialThemesOLD = pkgs.fetchgit {
      url = "https://github.com/spicetify/spicetify-themes";
      rev = "c2751b48ff9693867193fe65695a585e3c2e2133";
      sha256 = "0rbqaxvyfz2vvv3iqik5rpsa3aics5a7232167rmyvv54m475agk";
    };
    localFilesSrc = pkgs.fetchgit {
      url = "https://github.com/hroland/spicetify-show-local-files/";
      rev = "1bfd2fc80385b21ed6dd207b00a371065e53042e";
      sha256 = "01gy16b69glqcalz1wm8kr5wsh94i419qx4nfmsavm4rcvcr3qlx";
    };
in
{
  imports = [spicetify-nix.homeManagerModule];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
        playlistIcons
        spicetify-nix.packages.${pkgs.system}.default.extensions.adblock
        genre
        historyShortcut
        hidePodcasts
        fullAppDisplay
        shuffle
      ];
    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
    ];
      colorScheme = "custom";
     # theme = spicePkgs.themes.catppuccin-mocha;
      customColorScheme = with wave;{
        text = "${color7}";
        subtext = "${color15}";
        sidebar-text = "${color7}";
        main = "${background}";
        sidebar = "${mbg}";
        player = "${bg2}";
        card = "${color0}";
        shadow = "${color8}";
        selected-row = "${color8}";
        button = "${color4}";
        button-active = "${color4}";
        button-disabled = "${color5}";
        tab-active = "${color4}";
        notification = "${color3}";
        notification-error = "${color1}";
        misc = "${comment}";
      };
      

  };
}
