{pkgs, ...}: let
  getnfScript = builtins.readFile ./getnf.sh;

  getnf = pkgs.writeShellScriptBin "getnf" getnfScript;
in {
  home.packages = [getnf];
}
