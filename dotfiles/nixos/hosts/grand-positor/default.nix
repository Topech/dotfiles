{ lib, pkgs, ... }:

{
  networking.hostName = "grand-positor";

  imports = [
    ./users.nix
    ./hardware-configuration.nix
    ./boot-bugfix.nix
    ../../modules/gnome/FORCE-disable-gui-on-startup.nix
    ../../modules/gnome/gnome-wayland.nix
    ../../modules/ssh-access.nix
    ../../modules/llm/ollama/ollama-vulkan.nix
    ../../modules/llm/llama-cpp
    # ../../modules/nvidia/nvidia-geforce-gtx-1650.nix
    ../../modules/amd-radeon/nvtop.nix
    ../../modules/node-exporter.nix
    ../../modules/wol.nix
  ];
  

  # Install firefox.
  programs.firefox.enable = true;


  environment.systemPackages = with pkgs; [
    cowsay
  ];

  # Stop VM going to sleep / suspending
  powerManagement.enable = false;
}
