{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = "$directory$git_branch$character";
      character = {
      success_symbol = "[](#9ece6a bold)";
      error_symbol = "[](#db4b4b)";
      vimcmd_symbol = "[](#9ece6a)";
      };
      directory = {
        format = "[]($style)[[ ](bg:#292E42 fg:#7aa2f7)$path](bg:#292E42 fg:#c0caf5)[ ]($style)";
        style = "bg:#1a1b26 fg:#292E42";
      };
      git_branch = {
        format = "[]($style)[[ ](bg:#292E42 fg:#db4b4b)$branch](bg:#292E42 fg:#c0caf5)[]($style)";
        style = "bg:#1a1b26 fg:#292E42";
      };
    };
  };
}