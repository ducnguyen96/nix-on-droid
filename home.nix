{
  config,
  lib,
  pkgs,
  ...
}: {
  # Read the changelog before changing this value
  home.stateVersion = "23.05";

  home.homeDirectory = "/data/data/com.termux.nix/files/home";

  home.sessionVariables = {
    TERMINAL = "xterm-256color";
  };

  # insert home-manager config
  imports = [
    ./programs/git.nix
    ./programs/ranger.nix
    ./programs/neovim
    ./shell
  ];
}
