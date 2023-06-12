{ pkgs, ... }:{
   xsession.windowManager.bspwm = {
        enable = true;
        settings = {
            border_width = 0;
            window_gap = 5;
            top_padding = 30;
            bottom_padding = 30;
            left_padding = 30;
            right_padding = 30;
        };
        startupPrograms = [
            "feh --bg-fill ${./wallpapers/BluePeaks.jpg}"
        ];
        monitors = {
            "focused" = [
                "1"
                "2"
                "3"
                "4"
                "5"
            ];
        };
   }; 

   services.sxhkd = {
        enable = true;
        keybindings = {
            "super + Return" = "kitty";
            "super + shift + f" = "firefox";
            "super + shift + p" = "rofi -show p -modi p:rofi-power-menu";
            "super + d" = "rofi -show drun";

            "super + Escape" = "pkill -USR1 -x sxhkd";
            "super + shift + r" = "bspc wm -r";
            "super + q" = "bspc node -c";
            "super + {space}" = "bspc node -t {floating,tiled}";
            "super + {_,shift + }{1-5}" = "bspc {desktop -f,node -d} '^{1-5}'";
        };
   };
}
