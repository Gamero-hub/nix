{ config, pkgs,  }:

{

  programs.vscode = {
    enable = true;
    userSettings = {
      "workbench.colorTheme" = "Decayce";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.productIconTheme" = "fluent-icons";
      "editor.fontFamily" = "Dank Mono";
      "editor.cursorStyle" = "line";
      "editor.cursorBlinking" = "expand";
      "editor.fontSize" = 20;
      "terminal.integrated.fontSize" = 18;
      "window.menuBarVisibility" = "toggle";
      "editor.tabSize" = 2;
      "editor.inlineSuggest.enabled" = true;
      "tabnine.experimentalAutoImports" = true;
    };
    extensions = with pkgs.vscode-extensions; [
    ms-python.python
    vscodevim.vim
    bbenoist.nix
    tabnine.tabnine-vscode
    esbenp.prettier-vscode
    naumovs.color-highlight
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
   {
    name = "decay";
    publisher = "decaycs";
    version = "1.0.9";
    sha256 = "0i820baqn1w2bpzhgknhrafbkq3qz6rijh8h232j9v7rmvqfl02g";
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
     ];
  };

}