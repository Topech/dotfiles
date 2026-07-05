{
  description = "Configuration for all my hosts under NixOS";


  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
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
