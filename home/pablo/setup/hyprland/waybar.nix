{pkgs, ...}: let
#  waybar-hyprland = pkgs.callPackage ../../../../pkgs/waybar {};
  colors = import ../../theme/colors.nix {};
in {
  programs.waybar = {
    enable = true;
#    package = waybar-hyprland;
    style = with colors; ''
      * {
        all: unset;
        font-family: JetBrainsMono Nerd Font;
      }

      window#waybar {
        background-color: ${bg};
        color: ${fg};
        font-family: JetBrainsMono Nerd Font;
        padding: 20px;
      }

      image {
        margin: 0px 5px 0px 15px;
      }

      #workspaces button {
        font-family: JetBrainsMono Nerd Font;
        background-color: ${bg-contrast};
        min-height: 0;
        margin: 6px 4px;
        padding: 5px 14px;
        border: solid 2px transparent;
        transition: all ease 0.5s;
        border-radius: 7px;
      }

      #workspaces button.active {
        border: solid 2px ${accent};
        color: ${accent};
      }

      #workspaces button:nth-child(1) {
        margin-left: 10px;
      }

      #custom-track-icon {
        font-family: Material Symbols Rounded;
        background-color: ${teal};
        color: ${bg-contrast};
        margin: 8px 0px 8px 4px;
        padding-left: 8px;
        border-top-left-radius: 7px;
        border-bottom-left-radius: 7px;
      }
      
      #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 100px;
      }

      #custom-media.custom-spotify {
        background-color: #66cc99;
      }

      #custom-media.custom-vlc {
        background-color: #ffa000;
      }
      
      #custom-media,
      #wireplumber {
        padding: 0 10px;
        color: #ffffff;
        box-shadow: inset 0 -0.5em transparent;
        padding: 0.2rem 0.8rem;
        margin: 0.5rem 0.2rem;
        border-radius: 0.3em;
      }

      #wireplumber {
        background-color: #f0c674;
        color: #000000;
      }

      #wireplumber.muted {
        background-color: #90b1b1;
        color: #2a5c45;
      }

      #custom-track-name {
        font-family: JetBrainsMono Nerd Font;
        background-color: ${teal};
        color: ${bg-contrast};
        margin: 8px 0px;
        padding: 0px 4px 0px 8px;
      }

      #custom-track-prev,
      #custom-track-pause,
      #custom-track-next {
        font-family: Material Symbols Rounded;
        background-color: ${teal};
        color: ${bg-contrast};
        margin: 8px 0px;
        padding: 0px 2px;
      }

      #custom-track-next {
        padding-right: 8px;
        border-top-right-radius: 7px;
        border-bottom-right-radius: 7px;
      }

      #network.icon {
        font-family: Material Symbols Rounded;
        margin: 9px 0px 9px 8px;
        padding: 0px 8px;
        background-color: ${bg-contrast};
        border-top-left-radius: 7px;
        border-bottom-left-radius: 7px;
      }

      #network.label {
        background: ${bg-contrast};
        margin: 9px 0px;
        padding: 0px 8px 0px 0px;
        border-top-right-radius: 7px;
        border-bottom-right-radius: 7px;
      }

      #language {
        background-color: ${bg-contrast};
        padding: 0px 8px;
        margin: 8px;
        border-radius: 7px;
      }

      #clock {
        background: ${sapphire};
        color: ${bg-contrast};
        margin: 9px 0px;
        padding: 0px 8px;
        border-radius: 7px;
        font-size: 16px;
      }
      #pulseaudio,
      #backlight {
        background: ${pink};
        color: ${bg-contrast};
        margin: 8px 0px;
        font-family: Material Symbols Rounded;
        font-size: 20px;
      }

      #pulseaudio {
        margin-left: 8px;
        padding-left: 8px;
        border-top-left-radius: 7px;
        border-bottom-left-radius: 7px;
      }

      #backlight {
        padding: 0px 8px;
        border-top-right-radius: 7px;
        border-bottom-right-radius: 7px;
      }

      #battery.icon {
        font-family: Material Symbols Rounded;
        font-size: 28px;
        color: ${teal};
        background: ${bg-contrast};
        margin-left: 8px;
        padding: 0px 10px;
        margin: 8px 0px 8px 8px;
        border-top-left-radius: 7px;
        border-bottom-left-radius: 7px;
      }

      #battery.icon.warning {
        color: ${yellow};
      }

      #battery.icon.critical {
        color: ${red};
      }

      #battery.label {
        background: ${bg-contrast};
        padding: 0px 10px 0px 0px;
        margin: 8px 0px;
        border-top-right-radius: 7px;
        border-bottom-right-radius: 7px;
      }

      #custom-poweroff {
        font-family: Material Symbols Rounded;
        background-color: ${red};
        color: ${bg-contrast};
        margin: 8px 10px 8px 8px;
        padding: 0px 9px;
        border-radius: 7px;
        font-size: 16px;
      }
    '';
    settings = {
      mainBar = {
        "height" = 30;
        "layer" = "top";
        "modules-center" = ["clock"];
        "modules-left" = [
          "image/nixos"
          "wlr/workspaces"
          "custom/track-icon"
          "custom/track-name"
          "custom/track-prev"
          "custom/track-pause"
          "custom/track-next"
        ];
        "modules-right" = [
          "wireplumber"
          "custom/poweroff"
          "tray"
        ];
        "position" = "top";
        "image/nixos" = {
          "path" = "${./nixos.svg}";
          "size" = 20;
        };
        "custom/track-icon" = {
          "format" = "";
          "tooltip" = false;
          "exec" = "playerctl metadata --format '{{title}}'";
          "exec-if" = "pgrep spotify";
          "interval" = 1;
        };
        "custom/track-name" = {
          "tooltip" = false;
          "exec" = "playerctl metadata --format '{{title}}' | cut -c 1-17";
          "format" = "{}";
          "exec-if" = "pgrep spotify";
          "interval" = 1;
        };
        "custom/track-prev" = {
          "format" = "";
          "tooltip" = false;
          "exec" = "playerctl metadata --format '{{title}}'";
          "exec-if" = "pgrep spotify";
          "interval" = 1;
          "on-click" = "playerctl -p spotify previous";
        };
        "custom/track-pause" = {
          "format" = "";
          "tooltip" = false;
          "exec" = "playerctl metadata --format '{{title}}'";
          "exec-if" = "pgrep spotify";
          "interval" = 1;
          "on-click" = "playerctl -p spotify play-pause";
        };
        "custom/track-next" = {
          "format" = "";
          "tooltip" = false;
          "exec" = "playerctl metadata --format '{{title}}'";
          "exec-if" = "pgrep spotify";
          "interval" = 1;
          "on-click" = "playerctl -p spotify next";
        };
        "network#icon" = {
          "format" = "{icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
          "format-disconnected" = "";
          "max-length" = 1;
        };
        "network#label" = {
          "format" = "{ifname}";
          "format-wifi" = "{essid}";
          "format-ethernet" = "{iapddr}/{cidr}";
          "format-disconnected" = "Disconnected";
          "max-length" = 50;
        };
        "clock" = {
         # "format" = "{:%I:%M %p %A %d}";
           "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
           "format-alt" = "{:%Y-%m-%d}";
        };
        "pulseaudio" = {
          "format" = "{icon}";
          "format-icons" = [
            ""
            ""
            ""
          ];
        };
        "backlight" = {
          "format" = "{icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          "on-scroll-up" = "light -A 5";
          "on-scroll-down" = "light -U 5";
        };
        "battery#icon" = {
          "full-at" = 99;
          "interval" = 60;
          "format" = "{icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
          "max-length" = 25;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
        };
        "battery#label" = {
          "full-at" = 99;
          "interval" = 60;
          "format" = "{capacity}%";
          "max-length" = 25;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
        };
        "custom/poweroff" = {
          "format" = "";
          "on-click" = "poweroff";
          "tooltip" = false;
        };
        "wireplumber" = {
        "format"= "{volume}% {icon}";
        "format-muted"= "";
        "format-icons"= [
            ""
            ""
            ""
          ];
        };
        "custom/media" = {
          "format" = "{icon} {}";
          "return-type" = "json";
          "max-length" = 40;
          "format-spotify" = "";
          "format-default" = "🎜";
        };
     };
  };
  };
}