{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myBetaflight;
in
{
  options.myBetaflight = {
    # todo: make into list
    allowUsersUsbComms = mkOption {
      type = lib.types.str;
      description = "User to give groups, will let them use USB";
    };
  };

  config = {
    users.users."${cfg.allowUsersUsbComms}".extraGroups = [ "dialout" "plugdev" ];

    environment.systemPackages = with pkgs; [
      chromium
    ];

    programs.chromium = {
      enable = true;

      extraOpts = {
        WebAppInstallForceList = [
          {
            url = "https://app.betaflight.com";
            default_launch_container = "window";
            create_desktop_shortcut = true;
          }
        ];
      };
    };
  };
}
