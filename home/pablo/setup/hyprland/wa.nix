{ pkgs, ... }: 
let 
  in {
    programs.waybar = {
      enable = true;
      style = ''
        * {
          border: none;
          border-radius: 0px;
          font-family: LigaSFMono Nerd Font, Iosevka, FontAwesome, Noto Sans CJK;
          /* font-family: Iosevka, FontAwesome, Noto Sans CJK; */
          font-size: 12px;
          font-style: normal;
          min-height: 0;
        }

        window#waybar {
          background: rgba(16, 18, 19, 0.8);
          border-bottom: 1px solid #0c0e0f;
          color: #cdd6f4;
        }

        #workspaces {
          background: #0c0e0f;
          margin: 5px 5px;
          padding: 8px 5px;
          border-radius: 16px;
          border: solid 0px #cdd6f4;
          font-weight: normal;
          font-style: normal;
        }

        #workspaces button {
          padding: 0px 5px;
          margin: 0px 3px;
          border-radius: 16px;
          color: #2f354a;
          background-color: #2f354a;
          transition: all 0.3s ease-in-out;
        }

        #workspaces button.active {
          color: #cdd6f4;
          background-color: #cdd6f4;
          border-radius: 16px;
          min-width: 50px;
          background-size: 400% 400%;
          transition: all 0.3s ease-in-out;
        }

        #workspaces button:hover {
          background-color: #cdd6f4;
          color: #cdd6f4;
          border-radius: 16px;
          min-width: 50px;
          background-size: 400% 400%;
        }

        #custom-date, #clock, #battery, #pulseaudio, #network, #custom-randwall, #custom-launcher {
          background: transparent;
          padding: 5px 5px 5px 5px;
          margin: 5px 5px 5px 5px;
          border-radius: 8px;
          border: solid 0px #f4d9e1;
        }

        #custom-date {
          color: #D3869B;
        }

        #custom-power {
          color: #24283b;
          background-color: #db4b4b;
          border-radius: 5px;
          margin-right: 10px;
          margin-top: 5px;
          margin-bottom: 5px;
          margin-left: 0px;
          padding: 5px 10px;
        }

        #tray {
          background: #0c0e0f;
          margin: 5px 5px 5px 5px;
          border-radius: 16px;
          padding: 0px 5px;
        }

        #clock {
          color: #cdd6f4;
          background-color: #0c0e0f;
          border-radius: 0px 0px 0px 24px;
          padding-left: 13px;
          padding-right: 15px;
          margin-right: 0px;
          margin-left: 10px;
          margin-top: 0px;
          margin-bottom: 0px;
          font-weight: bold;
        }

        #battery {
          color: #9ece6a;
        }

        #battery.charging {
          color: #9ece6a;
        }

        #battery.warning:not(.charging) {
          background-color: #f7768e;
          color: #24283b;
          border-radius: 5px 5px 5px 5px;
        }

        #backlight {
          background-color: #24283b;
          color: #db4b4b;
          border-radius: 0px 0px 0px 0px;
          margin: 5px;
          margin-left: 0px;
          margin-right: 0px;
          padding: 0px 0px;
        }

        #network {
          color: #cdd6f4;
          border-radius: 8px;
          margin-right: 5px;
        }

        #pulseaudio {
          color: #cdd6f4;
          border-radius: 8px;
          margin-left: 0px;
          font-weight: bold;
        }

        #pulseaudio.muted {
          color: #242f33;
          border-radius: 8px;
          margin-left: 0px;
          font-weight: bold;
        }

        #custom-randwall {
          color: #cdd6f4;
          border-radius: 8px;
          margin-right: 0px;
        }

        #custom-launcher {
          color: #cdd6f4;
          background-color: #0c0e0f;
          border-radius: 0px 24px 0px 0px;
          margin: 0px 0px 0px 0px;
          padding: 0 20px 0 13px;
          font-size: 20px;
        }

        #custom-launcher button:hover {
          background-color: #FB4934;
          color: transparent;
          border-radius: 8px;
          margin-right: -5px;
          margin-left: 10px;
        }

        #custom-playerctl {
          background: #0c0e0f;
          padding: 0px 5px 0px 10px;
          border-radius: 16px;
          margin: 5px 7px;
          font-weight: normal;
          font-style: normal;
          font-size: 16px;
        }

        #custom-playerlabel {
          background: transparent;
          padding-left: 10px;
          padding-right: 5px;
          border-radius: 16px;
          margin-top: 5px;
          margin-bottom: 5px;
          font-weight: normal;
          font-style: normal;
        }

        #window {
          background: #0c0e0f;
          padding-left: 15px;
          padding-right: 15px;
          border-radius: 16px;
          margin-top: 5px;
          margin-bottom: 5px;
          font-weight: normal;
          font-style: normal;
        }

        #custom-wf-recorder {
          padding: 0 20px;
          color: #e5809e;
          background-color: #1E1E2E;
        }

        #cpu {
          background-color: #0c0e0f;
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
        }

        #memory {
          background-color: #0c0e0f;
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
        }

        #disk {
          background-color: #0c0e0f;
          border-radius: 16px;
          margin: 5px;
          margin-left: 5px;
          margin-right: 5px;
          padding: 0px 10px 0px 10px;
          font-weight: bold;
        }

    '';

    settings = {
      mainBar = {
        position = "top";
        layer = "top";
        height = 16;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["custom/launcher" "custom/playerctl" "custom/playerlabel"];
        modules-center = ["wlr/workspaces"];
        modules-right = ["tray" "pulseaudio" "clock"];
        clock = {
          format = " {:%H:%M}";
          tooltip = "true";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = " {:%d/%m}";
        };
        "wlr/workspaces" = {
          active-only = false;
          all-outputs = true;
          disable-scroll = false;
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
          sort-by-number = true;
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{icon} {time}";
          format-icons = ["" "" "" "" ""];
        };
        memory = {
          format = "󰍛 {}%";
          format-alt = "󰍛 {used}/{total} GiB";
          interval = 5;
        };
        cpu = {
          format = "󰻠 {usage}%";
          format-alt = "󰻠 {avg_frequency} GHz";
          interval = 5;
        };
        disk = {
          format = "󰋊 {}%";
          format-alt = "󰋊 {used}/{total} GiB";
          interval = 5;
          path = "/";
        };
        network = {
          format-wifi = "󰤨";
          format-ethernet = " {ifname}: Aesthetic";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "󰤭";
          format-alt = " {ifname}: {ipaddr}/{cidr}";
          tooltip-format = "{essid}";
          on-click-right = "nm-connection-editor";
        };
        tray = {
          icon-size = 16;
          spacing = 5;
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "bash ~/.scripts/volume mute";
          on-scroll-up = "bash ~/.scripts/volume up";
          on-scroll-down = "bash ~/.scripts/volume down";
          scroll-step = 5;
          on-click-right = "pavucontrol";
        };
        "custom/randwall" = {
          format = "󰏘";
          on-click = "bash $HOME/.config/hypr/randwall.sh";
          on-click-right = "bash $HOME/.config/hypr/wall.sh";
        };
        "custom/launcher" = {
          format = "";
          on-click = "bash $HOME/.config/rofi/launcher.sh";
          on-click-right = "bash $HOME/.config/rofi/run.sh"; 
          tooltip = "false";
        };
        "custom/wf-recorder" = {
          format = "{}";
          interval = "once";
          exec = "echo ''";
          tooltip = "false";
          exec-if = "pgrep 'wf-recorder'";
          on-click = "exec ./scripts/wlrecord.sh";
          signal = 8;
        };
        "custom/hyprpicker" = {
          format = "󰈋";
          on-click = "hyprpicker -a -f hex";
          on-click-right = "hyprpicker -a -f rgb";
        };
      };
    };
  };
}

