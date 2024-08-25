# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.kernelParams = [ "intel_idle.max_cstate=1" ];
  boot.consoleLogLevel = 0;
  boot.plymouth.enable = true;
  boot.uvesafb = {
    enable = true;
    gfx-mode = "1366x768-32";
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      gfxmodeEfi = "1366x768";
    };
  };

  networking.hostName = "pc1"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1";
    useXkbConfig = false; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb.layout = "de";
    #xkb.variant = "latin1";
    desktopManager.gnome.enable = true;
    desktopManager.cinnamon.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      firefox
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    spacevim
    starship
    wget
    fastfetch
    dracula-icon-theme
    dracula-theme
    nerdfonts
    rcm
    w3m
    vscode
    ksshaskpass
    arc-kde-theme
    arc-icon-theme
    materia-kde-theme
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = false;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
  
  virtualisation.virtualbox = {
    guest.enable = true;
    guest.draganddrop = true;
  };
  
  virtualisation.vmware = {
    guest.enable = true;
  };

  programs.ssh.askPassword = "ksshaskpass";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05"; # Did you read the comment?

}

