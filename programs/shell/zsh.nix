{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      code = "$HOME/Documents/Code";
      dots = "$HOME/Documents/Code/SideProjects/gorgeos";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
      mss = "$HOME/Music";
    };

    autosuggestion = {
      enable = true;
    };

    autocd = true;

    enableCompletion = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "cursor" "regexp" "root" "line"];
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      LC_ALL = "en_US.UTF-8";
    };

    initExtraBeforeCompInit = ''
      fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)
    '';

    completionInit = ''
      # Load Zsh modules
      zmodload zsh/zle
      zmodload zsh/zpty
      zmodload zsh/complist

      # Initialize colors
      autoload -Uz colors
      colors

      # Initialize completion system
      autoload -Uz compinit

      # if [[ -n ${config.home.homeDirectory}/.config/zsh/.zcompdump(#qN.mh+24) ]]; then
      #  compinit;
      # else
      #  compinit -C;
      # fi;
      compinit -C;

      _comp_options+=(globdots)

      # Load edit-command-line for ZLE
      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey "^e" edit-command-line

      # General completion behavior
      zstyle ':completion:*' completer _extensions _complete _approximate

      # Use cache
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

      # Complete the alias
      zstyle ':completion:*' complete true

      # Autocomplete options
      zstyle ':completion:*' complete-options true

      # Completion matching control
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' keep-prefix true

      # Group matches and describe
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'

      # Colors
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      # Directories
      zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
      zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
      zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
      zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
      zstyle ':completion:*' special-dirs false
      zstyle ':completion:*' squeeze-slashes true

      # Sort
      zstyle ':completion:*' sort false
      zstyle ":completion:*:git-checkout:*" sort false
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*:eza' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:files' sort false

    '';

    initExtra = ''
      # Vi mode key bindings
      bindkey -v
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey "^A" vi-beginning-of-line
      bindkey "^E" vi-end-of-line
    '';

    shellAliases = with lib;
    with pkgs; {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      cat = "${getExe bat} --style=plain";
      du = getExe du-dust;
      fzf = getExe skim;
      r = "rebuild";
      n = "nvim --listen /tmp/nvim-server.pipe";
      v = "nvim --listen /tmp/nvim-server.pipe";
      vim = "nvim --listen /tmp/nvim-server.pipe";
      nvim = "nvim --listen /tmp/nvim-server.pipe";
      g = "git";
      ga = "git add";
      gab = "git add . && rebuild";
      gc = "git commit";
      gp = "git push";
      gs = "git status";
      la = "${getExe eza} -lah --tree";
      ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      ps = getExe procs;
      tree = "${getExe eza} --tree --icons --tree";
      untar = "tar -xvf";
      untargz = "tar -xzf";
      awsume = ". awsume";
    };

    plugins = with pkgs; [
      {
        name = "zsh-forgit";
        src = pkgs.zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
      }
      {
        name = "zsh-fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
