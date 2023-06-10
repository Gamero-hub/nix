{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Pablo Segui";
    userEmail = "seguiaguilarpablo@gmail.com";
  };
}
