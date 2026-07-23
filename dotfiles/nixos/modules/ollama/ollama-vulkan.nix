{ pkgs, ...}:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    environmentVariables = {
     # general config
     OLLAMA_NO_CLOUD = "1";
     
     # model config
     OLLAMA_CONTEXT_LENGTH = "50000";
     OLLAMA_KEEP_ALIVE = "30m";
     OLLAMA_NUM_PARALLEL = "1";
     
     # speed up with cache
     OLLAMA_KV_CACHE_TYPE="q8_0";
    };
  };
}
