{ config, pkgs, ... }:

{
  home.sessionVariables = {
    PATH = "$HOME/.cargo/bin:$HOME/.local/bin:$PATH";
  };
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;
    enableCompletion = true;

    # Opcje historii i uzupełniania
    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };

    # Wtyczki Zsh (instalowane przez HM)
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "history-substring-search";
        src = pkgs.zsh-history-substring-search;
      }
    ];
    # ALIASY
    shellAliases = {
      cat = "bat";
      ls = "eza --icons";
      mv = "mv -v";
      cp_ = "rsync -ah --progress";
      #poweroff = "doas /sbin/poweroff"; # Wymaga skonfigurowanego 'doas' lub zmień na 'sudo'
      lu = "du -sh * | sort -h";
      rm = "rm -rfi"; 
      fetchtoo = "fastfetch --config examples/2.jsonc";
      #aria2torrent = "aria2c --bt-detach-seed-only";
      
      # Aliases YADM
      ya = "yadm add";
      yc = "yadm commit; yadm push";
      ys = "yadm status";
      
      # GIT
      ga = "git add .";
      gc = "git commit -m";

      # Screenshot
      screenshot = "grim -g \"$(slurp)\" - | swappy -f -";
      
      # nvim
      cheatvim = "fzf < ~/.config/nvim/nvim.md";
      vim = "nvim";
    };
    # KOD INICJALIZUJĄCY I WYKONYWALNY (zastępuje source $ZSH/...)
    initContent = ''
    # Ustaw kolor podpowiedzi (domyślnie szary)
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242" # Lekko szary
      # Akceptacja podpowiedzi prawą strzałką
      #bindkey ' ' autosuggest-insert
      #bindkey '^[[C' autosuggest-accept # Prawo
      #eval "$(oh-my-posh init zsh --config ~/.local/state/home-manager/gcroots/current-home/home-path/share/oh-my-posh/themes/peru.omp.json)"
      #eval "$(oh-my-posh init zsh --config $qq{pkgs.oh-my-posh}/share/oh-my-posh/themes/peru.omp.json)"
      eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config ${pkgs.oh-my-posh}/share/oh-my-posh/themes/peru.omp.json)"     
 
      # ZOXIDE
      eval "$(zoxide init zsh)"
      
      zstyle ':completion::complete:*' use-cache 1
      zstyle ':completion:*' menu select
      zstyle ':completion:*' group-name
      zstyle ':completion:*:descriptions' format '%B%d%b'
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    '';
  };
}
