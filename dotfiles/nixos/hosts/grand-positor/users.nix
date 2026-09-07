{ pkgs, ...}:

{
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
}
