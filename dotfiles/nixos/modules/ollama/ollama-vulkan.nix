{ pkgs, ...}:

{
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama-vulkan;
    environmentVariables = {
     # general config
     OLLAMA_NO_CLOUD = "1";
     
     # model config
     OLLAMA_CONTEXT_LENGTH = "40000";
     OLLAMA_NUM_PARALLEL = "1";
     # OLLAMA_KEEP_ALIVE = "30m";
     OLLAMA_KEEP_ALIVE = "-1";  # -1 = never unload

     
     # speed up with cache
     OLLAMA_KV_CACHE_TYPE="q8_0";
     # OLLAMA_KV_CACHE_TYPE="f16";
    };
  };
}
