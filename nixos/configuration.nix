{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #aktualny kernel   
  boot.kernelPackages = pkgs.linuxPackages_latest;
 
  # zram
  zramSwap.enable = true;
 
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hades"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fi9o = {
    isNormalUser = true;
    description = "fi9o";
    extraGroups = [ "wheel" "users"];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };
  
  programs.zsh.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.fi9o = {
      imports = [ ./home.nix ];
    };
  };

  # miedzy innmy do automout usb
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  # tailscale
  services.tailscale.enable = true;
  
  # aby sie pozbyc nano nalezy je wylaczyc jak nizej
  #programs.nano.enable = false;

  environment.systemPackages = with pkgs; [
      gtkgreet
      sway
      dconf
    ];  
  
  # 1. Definiujemy specjalny plik konfiguracyjny Swaya dla ekranu logowania
  environment.etc."greetd/login-sway.conf".text = ''
    # --- Ustawienia ogólne ---
    # Ustawiamy układ klawiatury (ważne przy wpisywaniu hasła!)
    input * xkb_layout pl

    # Tapeta (opcjonalnie - na razie czarne tło dla czytelności)
    output * bg #000000 solid_color

    # --- Konfiguracja GTKGREET ---
    # Uruchamiamy gtkgreet
    # Parametr '-l' mówi mu, żeby użył warstwy (layer-shell), co w Swayu działa lepiej
    exec "${pkgs.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    # Jeśli gtkgreet nie używa layer-shell (bez -l), musimy wymusić okno:
    # for_window [app_id="gtkgreet"] floating enable, center
    # motyw arc-dark dla gtkgreet
    #exec "GTK_THEME=Arc-Dark ${pkgs.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    #exec "GTK_THEME=Arc-Dark GTK_THEME_VARIANT=dark ${pkgs.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
    # Ważne: Greetd oczekuje, że proces 'command' będzie trwał. 
    # W tym przypadku Sway jest tym procesem.
    
    # Ukrywamy pasek Swaya na ekranie logowania
    bar { mode invisible }
    
    # Ewentualna naprawa monitorów (jeśli nadal są zamienione)
    # Odkomentuj i dostosuj, jeśli Sway też źle wykryje kolejność:
    # output DP-1 pos 0 0
    # output HDMI-A-1 pos 1920 0
  '';

  # Aktualizujemy konfigurację Greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config /etc/greetd/login-sway.conf";
        user = "greeter";
      };
    };
  };


  environment.etc."greetd/environments".text = ''
    sway
  '';
  
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  #Intel GPU
  hardware.graphics.extraPackages = with pkgs; [ intel-vaapi-driver intel-media-driver ];
  boot.kernelParams = [ "i915.force_probe=3e92" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05"; # Did you read the comment?

}
