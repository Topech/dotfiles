{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = lib.mkForce true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Required for eg: Steam, Wine, Proton
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # lets use OSS kernal module (user space still unfree)
    open = true;

    # modesetting required for modern DEs
    modesetting.enable = true;
    
    # power management is experimental.
    powerManagement.enable = false;
    
    # enable the nvidia settings menu
    nvidiaSettings = true;
    
    # the driver package
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

}
