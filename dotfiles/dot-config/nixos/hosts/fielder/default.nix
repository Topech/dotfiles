{ config, lib, pkgs, ... }:

{
  networking.hostName = "fielder";

  imports = [
    ./boot-bugfix.nix
    ./users.nix
    ./hardware-configuration.nix
    ../../modules/gnome/gnome-wayland.nix
    ../../modules/betaflight.nix
    # ../../modules/ssh-access.nix
    # ../../modules/llm/llama-cpp
  ];
  

  # Install firefox.
  programs.firefox.enable = true;

  myBetaflight.allowUsersUsbComms = "voldwart";

  environment.systemPackages = with pkgs; [
    cowsay
  ];

  # Stop VM going to sleep / suspending
  powerManagement.enable = false;
}
