{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./rebuild.nix
    ./getnf
  ];
}
