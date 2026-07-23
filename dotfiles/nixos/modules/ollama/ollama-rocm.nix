{ pkgs, ...}:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    environmentVariables = {
     # general config
     OLLAMA_NO_CLOUD = "1";
     
     # model config
     OLLAMA_CONTEXT_LENGTH = "20000";
     OLLAMA_KEEP_ALIVE = "30m";
     OLLAMA_NUM_PARALLEL = "1";
     
     # speed up with cache
     OLLAMA_KV_CACHE_TYPE="q4_0";

     # ensure it doesn't run out of vram and crash
     OLLAMA_GPU_OVERHEAD = "524288000"; # 500MB in bytes
    };
  };
}
