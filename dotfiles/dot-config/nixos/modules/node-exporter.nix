{ ... }:

{
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;

    # For the list of available collectors, run, depending on your install:
    # - Flake-based: nix run nixpkgs#prometheus-node-exporter -- --help
    # - Classic: nix-shell -p prometheus-node-exporter --run "node_exporter --help"
    # enabledCollectors = [ ];

    # required to expose beyond localhost
    openFirewall = true;
  };
}
