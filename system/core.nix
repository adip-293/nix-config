{ pkgs, ... }:
{
  # Bootloader. The ESP itself is declared in hardware-configuration.nix.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users.pabio = {
    isNormalUser = true;
    description = "Aditya Pola";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  services.openssh.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Lets unpatched prebuilt binaries run - the ones Zed and npm download at
  # runtime expect a filesystem layout NixOS does not have.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    openssl
    curl
    libgcc
  ];

  # git is needed to evaluate this flake at all.
  environment.systemPackages = with pkgs; [ git ];
}
