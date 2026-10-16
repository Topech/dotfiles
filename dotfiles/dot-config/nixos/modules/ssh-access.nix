{ lib, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;

    # lockdown ssh
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.openssh.openFirewall = true;
  networking.firewall.enable = true;
  networking.firewall.interfaces."enp6s0".allowedTCPPorts = lib.mkForce[ 22 ];
}
