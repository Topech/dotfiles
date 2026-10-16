# NixOS config

References:
- https://johns.codes/blog/organizing-system-configs-with-nixos
- https://ebzzry.com/en/flakes/


now how do I make this bootstrapped? as in get nixos config running on a machine AND keep it version controlled?
- save repo_dir in some variable?
- soft link flake.nix to /etc/nixos, then ref all other resources from repo_dir variable (as absolute paths)?
