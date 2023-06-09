{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./blocker.nix
    ./things.nix
  ];
}
