{
  neovim-flake,
  pkgs,
  ...
}: let
in {
  imports = [
    neovim-flake.homeManagerModules.default
  ];

  programs.neovim-flake = {

    enable = true;
    # your settings need to go into the settings attrset
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
    };
  };
}

