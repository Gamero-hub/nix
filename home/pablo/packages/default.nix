{ pkgs, inputs', ... }: {
  configure-gtk = pkgs.callPackage ./configure-gtk/default.nix {};
  dbus-sway-environment = pkgs.callPackage ./dbus-sway-environment {};
}
