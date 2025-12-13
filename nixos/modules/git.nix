{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "fi9o"; # Użyj swojego imienia/nicka
        email = "fi9o@example.com"; # Użyj swojego adresu e-mail
      };
      core.editor = "nvim";
    };

    # Jeśli używałeś wcześniej `extraConfig`, przenieś go do `settings`
    # np. `init.defaultBranch = "main";`

    # Opcjonalnie: integracja z HM (jeśli chcesz mieć gita w pakietach)
    # package = pkgs.git;
  };
}
