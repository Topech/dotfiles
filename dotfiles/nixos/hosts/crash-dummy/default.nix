{ pkgs, ... }:

{
  networking.hostName = "crash-dummy";

  imports = [
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/virtualbox-guest.nix
    ../../modules/gnome-wayland.nix
  ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.voldwart = {
    isNormalUser = true;
    description = "voldwart";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
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
