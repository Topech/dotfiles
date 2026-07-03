{ lib, ... }:

{
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.clipboard = true;

  # # Force NixOS to completely remove the broken Oracle hypervisor check from systemd user tier
  # # NOTE: required on Mac M1 chip, does not report the error
  systemd.user.services.virtualboxClientClipboard.unitConfig.ConditionVirtualization = lib.mkForce "";
  systemd.user.services.virtualboxClientSeamless.unitConfig.ConditionVirtualization = lib.mkForce "";
  systemd.user.services.virtualboxClientDisplay.unitConfig.ConditionVirtualization = lib.mkForce "";
}

