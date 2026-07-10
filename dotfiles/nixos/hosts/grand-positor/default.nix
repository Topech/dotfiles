{ pkgs, ... }:

{
  networking.hostName = "grand-positor";

  imports = [
    ./hardware-configuration.nix
    ./boot-bugfix.nix
    ../../modules/gnome-wayland.nix
    ../../modules/ssh-access.nix
    ../../modules/local-llm.nix
    ../../modules/nvidia-geforce-gtx-1650.nix
    ../../modules/node-exporter.nix
  ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.grumpert = {
    isNormalUser = true;
    initialPassword = "password";
    description = "grumpert";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    openssh.authorizedKeys.keys = [
     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO6aBy27Vbw1oiuBQE8zXh/PAREw+7QTEMBBbNHmWfyh mac"
    ];
  };


  # Install firefox.
  programs.firefox.enable = true;


  environment.systemPackages = with pkgs; [
    cowsay
  ];

  # Stop VM going to sleep / suspending
  powerManagement.enable = false;
}
