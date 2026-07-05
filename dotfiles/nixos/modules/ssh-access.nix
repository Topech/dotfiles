{ ... }:

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
}
