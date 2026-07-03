{ pkgs, ... }:

{
  imports = [
    ../modules/boot.nix
    ../modules/locale-aus-perth.nix
    ../modules/networking.nix
    ../modules/keyboard.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
  #  wget
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;
}
