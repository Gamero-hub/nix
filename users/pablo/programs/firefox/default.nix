{
  config,
  pkgs,
  nur,
  colors,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.pablo = {
      id = 0;
      settings."general.smoothScroll" = true;
      userChrome = import ./userChrome-css.nix {inherit colors;};
      userContent = import ./userContent-css.nix {};
    };
  };
}
