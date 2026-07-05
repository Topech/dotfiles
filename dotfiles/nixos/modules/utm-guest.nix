{ ... }:

{
  services.qemuGuest.enable = true;

  # for clipboard support
  services.spice-vdagentd.enable = true;
}
