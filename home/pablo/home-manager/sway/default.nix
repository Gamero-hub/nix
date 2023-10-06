{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./swaywm.nix
    ./fx.nix
  ];

  options = {
    wayland.windowManager.sway.fx = lib.mkEnableOption "swayfx";
  };

  config = {
    wayland.windowManager.sway = {
      enable = true;
      # Use NixOS module system to install
      package = null;
      systemd.enable = true;
    };
   };

}
