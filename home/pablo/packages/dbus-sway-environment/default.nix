{ lib, pkgs, ... }:
pkgs.writeTextFile {
   name = "dbus-sway-environment";
   destination = "/bin/dbus-sway-environment";
   executable = true;

   text = ''
     dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
     systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
     systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
};
