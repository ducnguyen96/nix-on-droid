{pkgs, ...}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    nix-on-droid switch --flake ~/SideProjects/nix-on-droid#default
  '';
in {
  home.packages = [rebuild];
}
