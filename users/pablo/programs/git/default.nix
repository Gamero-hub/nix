{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Pablo Segui";
    userEmail = "seguiaguilarpablo@gmail.com";
  };
  extraConfig = {
    credential = {
      credentialStore = "secretservice";
      helper = "/nix/store/5834mf7rd834g9panbqrl4z3r3dkfg8i-gh-2.20.2/bin/gh";
    };
  };
}
