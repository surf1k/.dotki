# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
   
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      splashImage = null;
      theme = /home/ym1co/niko-theme;
    };
    systemd-boot.enable = false;
  };
  services.usbmuxd.enable = true;
  services.flatpak.enable = true;
#  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  nix.settings = {
    # Увеличиваем буфер загрузки до 1 гигабайта (в байтах)
    download-buffer-size = 1073741824; 
    
    # Если у тебя уже есть другие настройки (например, авторы), просто допиши строку внутрь фигурных скобок
  };
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.hardware.openrgb.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ym1co = {
    isNormalUser = true;
    description = "ym1co";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  services.ratbagd.enable = true;

  programs.gpu-screen-recorder.enable = true;
  
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.fish.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kdePackages.kdenlive
    networkmanager-openvpn
    openvpn
    wgcf
    wireguard-tools
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    fastfetch
    kitty
    rofi
    python3
    blockbench
    easyeffects
    openrgb
    prismlauncher
    qbittorrent
    python313Packages.qtile-bonsai
    elmPackages.nodejs
    claude-code
    gemini-cli
    stow
    libreoffice
    firefox
    flatpak
    vscode
    codex
    duf
    davinci-resolve
    waybar
    hyprshade
    hyprpaper
    nwg-look
    file-roller
    tokyonight-gtk-theme
    papirus-icon-theme
    fish
    vesktop
    pavucontrol
    lunar-client
    git
    feh
    mpv
    telegram-desktop
    jq
    grim
    slurp
    wl-clipboard
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    steam
    mako
    hyprlock
    libnotify
    killall
    pulseaudio
    gpu-screen-recorder
    cava
    btop
    lavat
    cmatrix
    obs-studio
    asciiquarium
    cbonsai
    playerctl
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    font-awesome
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    
    # ФИКС: Официальный рабочий синтаксис для NixOS 25.11+
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
  ];

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
 
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ym1co"; # Замени на свое имя
  
  #Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
 
}
