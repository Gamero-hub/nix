{ config, pkgs,  }:

{

  programs.vscode = {
    enable = true;
    userSettings = {
      "workbench.colorTheme" = "Decayce";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.productIconTheme" = "fluent-icons";
      "editor.fontFamily" = "monospace";
      "editor.cursorStyle" = "line";
      "editor.cursorBlinking" = "expand";
      "editor.fontSize" = 18;
      "terminal.integrated.fontSize" = 18;
      "window.menuBarVisibility" = "toggle";
      "editor.tabSize" = 2;
      "editor.inlineSuggest.enabled" = true;
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
     ];
  };

}