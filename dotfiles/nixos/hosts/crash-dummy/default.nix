{ pkgs, ... }:

{
  # networking.hostName = "crash-dummy";
  networking.hostName = "nixos";

  imports = [
    ./users.nix
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/utm-guest.nix
    ../../modules/gnome/gnome-wayland.nix
    ../../modules/ssh-access.nix
  ];


  # Install firefox.
  programs.firefox.enable = true;


  environment.systemPackages = with pkgs; [
    cowsay
  ];

  # Stop VM going to sleep / suspending
  powerManagement.enable = false;
}
