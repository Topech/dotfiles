{ pkgs, ...}:

{
  imports = [ ./ollama-common.nix ]

  services.ollama.package = pkgs.unstable.ollama-vulkan;
}
