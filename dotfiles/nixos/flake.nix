{
  description = "Configuration for all my hosts under NixOS";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };


  outputs = { self, nixpkgs, ... } : {
    nixosConfigurations = {

      crash-dummy = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/common.nix
          ./configuration.nix
          # ---
          ./hosts/crash-dummy
        ];
      };

      # grand-positor = nixpkgs.lib.nixosSystem {...
    };
  };
}
