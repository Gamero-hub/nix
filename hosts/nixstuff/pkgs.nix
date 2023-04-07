{ config,
  pkgs,
  ...
}:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
environment.systemPackages = with pkgs; [
  drawing
  lunar-client
  vim
  (python39.withPackages(ps: with ps; [ readchar ]))
  nix-prefetch-git
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
  fish
  kitty
  rofi
  cava
  jq
  pcmanfm
  blueman
  git
  bat
  discord
  htop
  tree
  lsd
  pywal
  font-manager
  slstatus
  gh
  feh 
  htop
  pavucontrol
  unstable.jetbrains.pycharm-community
  neofetch
];
}
