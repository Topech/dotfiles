{ config, lib, ... }:

{
  options = {
    wol = {
      net_interface = lib.mkOption {
        type = lib.types.str;
        description = "The physical ethernet network interface targeted for Wake-on-LAN routing.";
      };
    };
  };

  config = {
    networking.interfaces."${config.wol.net_interface}".wakeOnLan.enable = true;
  };
}
