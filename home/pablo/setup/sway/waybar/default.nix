{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
  };

  xdg.configFile = {
    "waybar/config" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.unsafeFlakePath}/modules/home-manager/waybar/config.json";
    };
    "waybar/style.css" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.unsafeFlakePath}/modules/home-manager/waybar/style.css";
    };
  };
}
