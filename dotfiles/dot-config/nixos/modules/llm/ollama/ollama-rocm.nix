{ pkgs, ...}:

{
  imports = [ ./ollama-common.nix ]

  services.ollama = {
    package = pkgs.ollama-rocm;

    environmentVariables = {
     # ensure it doesn't run out of vram and crash
     OLLAMA_GPU_OVERHEAD = "524288000"; # 500MB in bytes
    };
  };
}
