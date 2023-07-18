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
      mouse = "xinput --set-prop 12 309 -0.75";
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

  plugins = with pkgs; [
      {
        name = "forgit"; # i forgit :skull:
        file = "forgit.plugin.zsh";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "99cda3248c205ba3c4638c4e461afce01a2f8acb";
          sha256 = "0jd0nl0nf7a5l5p36xnvcsj7bqgk0al2h7rdzr0m1ldbd47mxdfa";
        };
      }
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "13d7b4e63468307b6dcb2dadf6150818f242cbff";
          sha256 = "0ghzqg1xfvqh9z23aga7aafrpxbp9bpy1r8vk4avi6b80p3iwsq2";
        };
      }
      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
          sha256 = "0q9wg8jlhlz2xn08rdml6fljglqd1a2gbdp063c8b8ay24zz2w9x";
        };
      }
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "5a81e13792a1eed4a03d2083771ee6e5b616b9ab";
          sha256 = "0lfl4r44ci0wflfzlzzxncrb3frnwzghll8p365ypfl0n04bkxvl";
        };
      }
    ];

  };
}
