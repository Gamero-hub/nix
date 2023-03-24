{ config, pkgs,  }:

{

  programs.vscode = {
    enable = true;
    userSettings = {
      "workbench.colorTheme" = "Decayce";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.productIconTheme" = "fluent-icons";
      "editor.bracketPairColorization.enabled" = false;
      "editor.fontFamily" = "monospace";
      "editor.fontLigatures" = true;
      "editor.cursorStyle" = "line";
      "editor.cursorBlinking" = "expand";
      "editor.fontSize" = 18;
      "terminal.integrated.fontSize" = 18;
      "window.menuBarVisibility" = "toggle";
      "editor.tabSize" = 2;
      "editor.inlineSuggest.enabled" = true;
      "vim.cursorStyle" = "line";
      "[python]"."editor.tabSize" = 4;
    };
    extensions = with pkgs.vscode-extensions; [
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
    name = "Nix";
    publisher = "bbenoist";
    version = "1.0.1";
    sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
  }
  {
    name = "decay";
    publisher = "decaycs";
    version = "1.0.9";
    sha256 = "0i820baqn1w2bpzhgknhrafbkq3qz6rijh8h232j9v7rmvqfl02g";
  }
  {
    name = "prettier-vscode";
    publisher = "esbenp";
    version = "9.10.4";
    sha256 = "0br00867d2p0d7fjw8ska3anz16rfyhh3b2i6fpfi6qv8h3p46wj";
  }
  {
    name = "fluent-icons";
    publisher = "miguelsolorio";
    version = "0.0.18";
    sha256 = "02zrlaq4f29vygisgsyx0nafcccq92mhms420qj0lgshipih0kdh";
  }
  {
    name = "material-icon-theme";
    publisher = "PKief";
    version = "4.25.0";
    sha256 = "0abk642gdf3d4n7nynr835gcb091qwnvjpdlig7ga5sxns5zfl7y";
  }
  {
    name = "vim";
    publisher = "vscodevim";
    version = "1.25.2";
    sha256 = "0j0li3ddrknh34k2w2f13j4x8s0lb9gsmq7pxaldhwqimarqlbc7";
  }
  {
    name = "LiveServer";
    publisher = "ritwickdey";
    version = "5.7.9";
    sha256 = "0dycc18i1zn20zgh5ymqbi1nmg2an49ndf9r2w6dr5lx8d49hh63";
  }
  {
    name = "color-highlight";
    publisher = "naumovs";
    version = "2.6.0";
    sha256 = "1ssh5d4kn3b57gfw5w99pp3xybdk2xif8z6l7m3y2qf204wd1hsd";
  }
  {
    name = "python";
    publisher = "ms-python";
    version = "2023.5.10831011";
    sha256 = "011gcm4bfxpqlp655nrdlj9b7gybb6hj77s6225bciq2y058c49g";
  }
  {
    name = "vscode-pylance";
    publisher = "ms-python";
    version = "2023.3.31";
    sha256 = "09lm977r1bxm44lw7fiakjk4p9v5nhas3rdvgmwihzcpj7dm8v8p";
  }
  {
    name = "jupyter";
    publisher = "ms-toolsai";
    version = "2023.3.1000851011";
    sha256 = "0v0frndcppk61sw6w3pdcl0bldin6si9k0hck0865d1g5niqz1sn";
  }
  {
    name = "jupyter-keymap";
    publisher = "ms-toolsai";
    version = "1.1.0";
    sha256 = "1i3qjvw5mmj53ysp0vgnjs48191raxkycbhp5gsrg229wr3yvc4j";
  }
  {
    name = "jupyter-renderers";
    publisher = "ms-toolsai";
    version = "1.0.15";
    sha256 = "101mjb5qapm8m4h46pxshvw43pfnzw4ii1ilm893nifigfx8y7i5";
  }
  {
    name = "vscode-jupyter-cell-tags";
    publisher = "ms-toolsai";
    version = "0.1.8";
    sha256 = "14zzr0dyr110yn53d984bk6hdn0mgva4jxvxzihvsn6lv6kg50yj";
  }
  {
    name = "vscode-jupyter-slideshow";
    publisher = "ms-toolsai";
    version = "0.1.5";
    sha256 = "1p6r5vkzvwvxif3wxqi9599vplabzig27fzzz0bx9z0awfglzyi7";
  }
     ];
  };

}
