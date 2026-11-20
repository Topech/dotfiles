{ config, lib, ... }:

{
    options.wg-home = {
        serverEndpoint = lib.mkOption {
            type = lib.str;
            description = "endpoint to reach server";
        };
        serverPrivateKeyPath = lib.mkOption {
            type = lib.str;
            description = "path to servers private key";
        };
        vpnSubnet = lib.mkOption {
            type = lib.str;
            default = "10.8.0.0/24";
            description = "subnet for vpn traffic to route through VPN";
        };
        clientPublicKey = lib.mkOption {
            type = lib.str;
            description = "the public key content for this machine, as assigned from the server";
        };
        clientAddress = lib.mkOption {
            type = lib.str;
            description = "the address designated for the client in the VPN, as assigned from the server";
        };
      };

    config = let
        cfg = config.wg-home;
    in config {
        networking.wg-quick.interfaces.wg0 = {
            addresses = cfg.clientAddress;
            privateKeyfile = cfg.serverPrivateKeyPath;
            peers = [{
                publicKey = cfg.clientPublicKey;
                allowedIPs = cfg.vpnSubnet;  # only VPN traffic through this peer
                endpoint = cfg.serverEndpoint;
                persistentKeepalive = 25;
            }];
        };
    };
}
