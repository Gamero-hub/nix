{ config, pkgs, decay-color, ... }:

{
  programs.rofi = {
    enable = true;
    font = "JetBrains Mono Medium Nerd Font Complete 12";
    extraConfig = {
      modi = "drun";
      display-drun = "";
      show-icons = true;
      drun-display-format = "{name}";
      sidebar-mode = false;
    };
    theme = import ./theme.nix { inherit config decay-color; };
  };
}