{ pkgs, ... }:

{
  networking.hostName = "crash-dummy";

  imports = [
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/utm-guest.nix
    # ../../modules/gnome-wayland.nix
    ../../modules/ssh-access.nix
  ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.voldwart = {
    isNormalUser = true;
    initialPassword = "password";
    description = "voldwart";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    openssh.authorizedKeys.keys = [
     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG+xzvvno+TTRw+5dpZk/s26julOX+nNkF5t5h/rxhnZ local-vm"
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
