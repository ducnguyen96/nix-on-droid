{pkgs, ...}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    nix-on-droid switch --flake ~/nix-on-droid#default
  '';
in {
  home.packages = [rebuild];
}
