{ config, lib, pkgs, ...}:

{
  options.mainUsername = lib.mkOption {
    type = lib.types.str;
    description = "The main user for the machine";
  };

  config = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.mainUsername} = {
      isNormalUser = true;
      initialPassword = "password";
      description = "main user for the machine";
      extraGroups = [ "networkmanager" "wheel" ];
      openssh.authorizedKeys.keys = [
       "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO6aBy27Vbw1oiuBQE8zXh/PAREw+7QTEMBBbNHmWfyh mac"
      ];
    };
  };
}
