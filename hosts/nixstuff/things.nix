{ pkgs, outputs, overlays, lib, inputs, config, ... }:
{
  security = {
    sudo.enable = true;
  };

   time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Madrid";
  };
  users = {
    users.pablo = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
      packages = with pkgs; [ ];
    };
    defaultUserShell = pkgs.zsh;
  };
  fonts = {
    fonts = with pkgs; [
      inter
      lato
      maple-mono
      maple-mono-NF
      noto-fonts
      (nerdfonts.override { fonts = [ "Iosevka" "CascadiaCode" "JetBrainsMono" ]; })
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };

      subpixel.lcdfilter = "default";

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["Dank Mono"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
      };
    };
    };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  # Vm
  boot.kernelModules = [ "kvm-intel" "vfio-pci" ];
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt"];

  environment.systemPackages = with pkgs; [
  unstable.gtk3
  unstable.st
  unstable.spotdl
  unstable.simplescreenrecorder
  unstable.nix-prefetch-git
  unstable.maim
  unstable.xorg.xf86inputevdev
  unstable.xorg.xf86inputsynaptics
  unstable.xorg.xf86inputlibinput
  unstable.xorg.xorgserver
  unstable.xorg.xf86videoati
  unstable.vim
  (python39.withPackages(ps: with ps; [ readchar pyttsx3 pyaudio pip ]))
  unstable.nix-prefetch-git
  unstable.git
  unstable.picom
  unstable.nix-prefetch-github
  unstable.unzip
  unstable.yt-dlp
  unstable.neovim
  unstable.firefox
  unstable.lua54Packages.lua
  unstable.wezterm
  unstable.vscode-fhs
  unstable.starship
  unstable.mpv
  unstable.helix
  unstable.sxhkd
  unstable.feh
  unstable.zsh
  unstable.kitty
  unstable.rofi
  unstable.cava
  unstable.pcmanfm
  unstable.blueman
  unstable.bat
  unstable.discord
  unstable.htop
  unstable.tree
  unstable.lsd
  unstable.pywal
  unstable.font-manager
  unstable.slstatus
  unstable.feh
  unstable.htop
  unstable.pavucontrol
  unstable.jetbrains.pycharm-community
  unstable.neofetch
  # Vm
  
  unstable.libvirt
  unstable.pciutils
  unstable.virt-manager
  unstable.qemu
  unstable.kmod
  ];

  environment.shells = with pkgs; [ zsh ];

  programs.dconf.enable = true;

  system = {
    stateVersion = "22.11";
  };
}
