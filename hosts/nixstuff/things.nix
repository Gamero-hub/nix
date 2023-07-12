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
  gtk3
  st
  spotdl
  simplescreenrecorder
  nix-prefetch-git
  maim
  xorg.xf86inputevdev
  xorg.xf86inputsynaptics
  xorg.xf86inputlibinput
  xorg.xorgserver
  xorg.xf86videoati
  vim
  steam
  direnv
  lutris
  nix-prefetch-git
  git
  picom
  nix-prefetch-github
  unzip
  yt-dlp
  neovim
  firefox
  vscode-fhs
  starship
  mpv
  helix
  sxhkd
  feh
  zsh
  kitty
  rofi
  cava
  pcmanfm
  blueman
  bat
  discord
  htop
  tree
  lsd
  pywal
  font-manager
  slstatus
  feh
  htop
  pavucontrol
  jetbrains.pycharm-community
  neofetch
  # Vm
  
  libvirt
  pciutils
  virt-manager
  qemu
  kmod
  ];

   environment.shells = with pkgs; [ zsh ];

  programs.dconf.enable = true;

  system = {
    stateVersion = "22.11";
  };
}
