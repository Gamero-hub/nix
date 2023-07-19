{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      nh = "sudo nixos-rebuild switch --flake .#highland --impure";
      nl = "sudo nixos-rebuild switch --flake .#lowland --impure";
      mouse = "xinput --set-prop 'E-Signal USB Gaming Mouse' 'libinput Accel Speed' -0.75";
      xrand = "xrandr --output HDMI-0 --mode 1920x1080 --rate 144";
      ls = "lsd";
      gg = "git add .; git commit -m '.'; git push -u origin main";
    };
    history = {
      expireDuplicatesFirst = true;
      save = 512;
    };
  
  oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = [
        "git"
        "git z"
        "colorize"
        "colored-man-pages"
        "command-not-found"
        "history-substring-search"
      ];
    }; 
      zshrc = ''
    # Direnv init
    export direnv_config_dir=${direnvConfig}
    eval "$(direnv hook zsh)"

  '';

  };
}
