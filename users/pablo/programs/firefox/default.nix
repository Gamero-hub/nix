{ config, pkgs, colors, ... }:

{
  programs.firefox = {
    enable = true;

    profiles = {
      myprofile = {
        id = 0;

        settings = {
          "browser.startup.homepage" = "https://gs.is-a.dev/startpage/";
          "general.smoothScroll" = true;
        };

        userChrome = import ./userChrome-css.nix {
          inherit colors;
        };

        userContent = import ./userContent-css.nix {
          inherit colors;
        };

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
          user_pref("extensions.pocket.enabled", false);
        '';
      };
    };
  };
}
