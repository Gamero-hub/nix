{ pkgs, config, ... }:

{
  wayland.windowManager.sway = {
    config = null;
    extraConfig = ''

    gaps inner 5
    gaps outer 0

    input "type:keyboard" {
    xkb_layout es
    }

    input "type:pointer" {
    accel_profile flat
    pointer_accel 0.0
    }

    set $term kitty
    set $mod mod4

    bindsym $mod+Return exec $term
    bindsym $mod+q kill
    bindsym $mod+Shift+r reload
    bindsym $mod+d exec pkill rofi || ~/.config/rofi/launcher.sh
    bindsym $mod+Shift+space floating toggle

    smart_gaps on

    '';
    };
}
