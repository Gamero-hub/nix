{ pkgs, ... }: {
    services.picom = {
        enable = true;
        package = pkgs.picom-pijulius;

        backend = "glx";

        fade = true;
        fadeSteps = [
            0.03
            0.03
        ];

        vSync = true;

        settings = {
            corner-radius = 10;

            animations = true;
            animations-stiffness = 300;
            animation-dampening = 20;
            animation-clamping = true;

            animation-for-open-window = "zoom";
            animation-for-unmap-window = "zoom"; #minimize window
            animation-for-menu-window = "none";
            animation-for-transient-window = "none"; #popup windows
        };
    };
}
