{ lib, ... }:

{
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  boot.loader.grub = {
    enable = true;
    device = "/dev/disk/by-id/ata-ST500LM021-1KJ152_W622D956";
  };
}
