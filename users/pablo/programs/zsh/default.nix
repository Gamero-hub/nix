{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;

    shellAliases = {
      nh = "sudo nixos-rebuild switch --flake .#highland --impure";
      mouse = "xinput set-prop 9 'Device Accel Constant Deceleration' 2";
      xrand = "xrandr --output HDMI-0 --mode 1920x1080 --rate 144";
      ls = "lsd";
      gg="git add.; git commit -m "."; git push -u origin main"
    };
    history = {
      expireDuplicatesFirst = true;
      save = 512;
    };
    initExtra = ''
      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[4~"   end-of-line
      bindkey  "^[[3~"  delete-char
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$cmd_duration\n[ ](fg:blue)  ";
      git_branch.format = "via [$symbol$branch(:$remote_branch)]($style) ";
      command_timeout = 1000;
    };
  };
}
