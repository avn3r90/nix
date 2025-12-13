{ config, pkgs, ... }:

{
  # Podstawowe dane użytkownika
  home.username = "fi9o";
  home.homeDirectory = "/home/fi9o";

  # Wersja stanu (nie zmieniaj tego przy aktualizacjach systemu)
  home.stateVersion = "25.05"; 

  imports = [
  ./modules/git.nix
  ./modules/zsh.nix
  ./modules/theme.nix
  #./modules/firefox.nix
  ./modules/sway.nix
  #./modules/flatpak.nix
  ];

  # Przykład: Instalacja pakietów tylko dla użytkownika
  home.packages = with pkgs; [
  # Wayland i towarzystwo
  grim
  slurp
  swappy
  wl-clipboard
  xwayland
  
  # Czcionki
  fira
  fira-code
  font-awesome

  # Desktopowe
  blueman
  calibre
  kitty
  librewolf
  pavucontrol
  pcmanfm
  signal-desktop
  thunderbird
  ungoogled-chromium
  xdg-user-dirs

  # Aplikacje tui/cli
  asciinema
  bat
  btop
  eza
  fastfetch
  fzf
  gh
  git
  grc
  microfetch
  mpv
  neovim
  nix-search-cli
  nh
  nvd
  oh-my-posh
  patool
  spotify-player
  tldr
  wget
  yadm
  yazi
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-syntax-highlighting
  zoxide
  ];
  

  xdg.mimeApps = {
    enable = true;
    
    # Definiowanie domyślnych aplikacji
    defaultApplications = {
      # Przeglądarka internetowa:
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "image/jpeg" = [ "swappy.desktop" ];
      "image/png" = [ "swappy.desktop" ];
      "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
      "inode/directory" = [ "pcmanfm.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/x-msvideo" = [ "mpv.desktop" ];
    };
  };
  
  
  # Włączenie samego Home Managera
  programs.home-manager.enable = true;
}
