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
      zshrc = writeTextDir "${zdotdir}/.zshrc" ''
    # Only source this file once
    # if ! [ -z ''${_NIX_ZSHRC_SOURCED+x} ]; then
    #   exit
    # fi

    if [ -z ''${XDG_CACHE_HOME+x} ]; then
        export ZSH_CACHE="''${XDG_CACHE_HOME}/zsh"
    else
        export ZSH_CACHE="''${HOME}/.cache/zsh"
    fi

    if ! mkdir -p "$ZSH_CACHE"; then
        echo "Warning: error creating $ZSH_CACHE"
        export ZSH_CACHE=/tmp
        echo "Setting it to $ZSH_CACHE"
    fi




    # Direnv init
    export direnv_config_dir=${direnvConfig}
    eval "$(direnv hook zsh)"

    export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

    export _NIX_ZSHRC_SOURCED=1
  '';

  };
}
