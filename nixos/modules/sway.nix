{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    mako
    sway
    swaybg
    swayidle
    swaylock
    waybar
    wofi
  ];

  # sway
  xdg.configFile."sway/config".source = ../dotfiles/sway/config;
  
  # waybar
  xdg.configFile."waybar/config".source = ../dotfiles/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ../dotfiles/waybar/style.css;
  
  # mako
  xdg.configFile."mako/config".source = ../dotfiles/mako/config;

  # wofi
  xdg.configFile."wofi/config".source = ../dotfiles/wofi/config;
  xdg.configFile."wofi/menu".source = ../dotfiles/wofi/menu.css;

}


