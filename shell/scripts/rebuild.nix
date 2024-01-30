{pkgs, ...}: let
  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    nix-on-droid switch --flake ~/#default
  '';
in {
  home.packages = [rebuild];
}
