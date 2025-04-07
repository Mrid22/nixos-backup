# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  systemd.extraConfig = "DefaultLimitNOFILE=2048";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Hong_Kong";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_HK.UTF-8";

  # Enable the X11 windowing system.
  services = {
    printing.enable = true;
    blueman.enable = true;
    flatpak.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  security.rtkit.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  nixpkgs.config.allowUnfree = true;
  users.users.mridula = {
    isNormalUser = true;
    description = "Mridul Agarwal";
    extraGroups = [ "networkmanager" "wheel" ];
  };


# Apps


  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  environment.systemPackages = with pkgs; [
    home-manager
    kdePackages.qtsvg
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.dolphin
    kdePackages.ark
    zsync
    (import ./reload.nix { inherit pkgs; })
  ];
  
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      mridula = import ./home.nix;
    };
  };

  # nix package manager
  nix = {
    settings = {
      experimental-features =  [ "nix-command" "flakes" ];
      trusted-users =  [ "root" "mridula" ];
      max-jobs= 20;
      cores= 20;
    };
  };
  system.stateVersion = "24.11"; # Did you read the comment?

}
