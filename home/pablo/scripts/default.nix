{ config, lib, pkgs, ... }:

let
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
    if command -v swww >/dev/null 2>&1; then 
        killall dynamic_wallpaper
        swww img $(find ~/wallpapers/. -name "*.png" | shuf -n1) --transition-type random
    else 
        killall swaybg
        killall dynamic_wallpaper
        swaybg -i $(find ~/wallpapers/. -name "*.png" | shuf -n1) -m fill &
    fi
  '';
  dynamic_wallpaper = pkgs.writeShellScriptBin "dynamic_wallpaper" ''
    if command -v swww >/dev/null 2>&1; then 
        swww img $(find ~/wallpapers/. -name "*.png" | shuf -n1) --transition-type random
        OLD_PID=$!
        while true; do
            sleep 120
        swww img $(find ~/wallpapers/. -name "*.png" | shuf -n1) --transition-type random
            NEXT_PID=$!
            sleep 5
            kill $OLD_PID
            OLD_PID=$NEXT_PID
        done
    elif command -v swaybg >/dev/null 2>&1; then  
        killall swaybg
        swaybg -i $(find ~/wallpapers/. -name "*.png" | shuf -n1) -m fill &
        OLD_PID=$!
        while true; do
            sleep 120
            swaybg -i $(find ~/wallpapers/. -name "*.png" | shuf -n1) -m fill &
            NEXT_PID=$!
            sleep 5
            kill $OLD_PID
            OLD_PID=$NEXT_PID
        done
    else 
        killall feh 
        feh --randomize --bg-fill $(find ~/wallpapers/. -name "*.png" | shuf -n1) &
        OLD_PID=$!
        while true; do
            sleep 120
            feh --randomize --bg-fill $(find ~/wallpapers/. -name "*.png" | shuf -n1) &
            NEXT_PID=$!
            sleep 5
            kill $OLD_PID
            OLD_PID=$NEXT_PID
        done
    fi
  '';
  launch_waybar = pkgs.writeShellScriptBin "launch_waybar" ''
    #!/bin/bash
    if pgrep -x "waybar" > /dev/null; then
        pkill waybar
    fi

    waybar > /dev/null 2>&1
  '';
in
{
  home.packages = with pkgs; [
    wallpaper_random
    dynamic_wallpaper
    launch_waybar
  ];
}
