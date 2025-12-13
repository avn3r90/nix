# ~/.config/nixos/flatpak.nix

{ config, pkgs, ... }:

{
  programs.flatpak.enable = true;

  # Aplikacje Flatpak instalowane dla użytkownika (deklaratywnie)
  services.flatpak.packages = [
    # Przykłady popularnych aplikacji
    "com.stremio.Stremio"
  ];
  
  # Opcjonalnie: Ustawienie domyślnych repozytoriów, jeśli nie są ustawione systemowo
  services.flatpak.globalRepos = true;
  services.flatpak.extraRepos = [
    {
      url = "https://flathub.org/repo/flathub.flatpakrepo";
      name = "flathub";
    }
  ];
}
