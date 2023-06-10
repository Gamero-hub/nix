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
      credential.helper = "${pkgs.local.gh}/bin/gh";
    };
  };
}
