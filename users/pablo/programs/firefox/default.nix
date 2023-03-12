{ config, pkgs, nur, colors, ... }:

{
  programs.firefox = {
    enable = true;
     
    profiles.pablo = {
      id = 0;
      settings."general.smoothScroll" = true;
      userChrome = import ./userChrome-css.nix { inherit colors; };
      userContent = import ./userContent-css.nix {};
      extraConfig = ''
        user_pref("browser.startup.homepage", "https://gamero-hub.github.io/page");
        user_pref("browser.urlbar.autoFill", false);
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("layers.acceleration.force-enabled", true);
        user_pref("gfx.webrender.all", true);
        user_pref("svg.context-properties.content.enabled", true);
        user_pref("full-screen-api.ignore-widgets", true);
        user_pref("media.ffmpeg.vaapi.enabled", true);
        user_pref("media.rdd-vpx.enabled", true);
      '';
    };
  };
}
