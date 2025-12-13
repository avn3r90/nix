# ~/.config/nixos/modules/theme.nix

{ pkgs, config, ... }:

{
  # -------------------------------------------------------------------------
  # 1. Kursor Myszki (Pointer Cursor)
  # -------------------------------------------------------------------------
  home.pointerCursor = {
    gtk.enable = true;
    # Zostawiamy Bibata, bo to niezależny element
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # -------------------------------------------------------------------------
  # 2. Motyw GTK (Qogir Dark)
  # -------------------------------------------------------------------------
  gtk = {
    enable = true;

    theme = {
      # Używamy motywu Qogir Dark
      name = "Qogir-Dark";
      package = pkgs.qogir-theme;
    };

    iconTheme = {
      # Używamy zestawu ikon Qogir
      # Dostępne są warianty: Qogir, Qogir-dark, Qogir-light
      name = "Qogir-Dark";
      package = pkgs.qogir-icon-theme;
    };

    font = {
      #name = "Fira Sans";
      name = "Liberation Sans";
      package = pkgs.fira;
      size = 10;
    };
    
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  # -------------------------------------------------------------------------
  # 3. Integracja Qt
  # -------------------------------------------------------------------------
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "gtk2";
  };
}
