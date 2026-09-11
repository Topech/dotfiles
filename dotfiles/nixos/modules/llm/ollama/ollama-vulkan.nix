{ config, pkgs, ...}:

{
  # NOTE: ollama uses different storage convention, so let it manage its own models
  # imports = [ ../llm-shared.nix ];
  # users.users.ollama.extraGrups = [ "${config.llm.sharedModels.group}" ];


  services.ollama = {
    enable = false;  # NOTE: disabled for now
    package = pkgs.unstable.ollama-vulkan;
    
    # NOTE: ollama uses different storage convention, so let it manage its own models
    # models = "${config.llm.sharedModels.dir}"

    environmentVariables = {
     # general config
     OLLAMA_NO_CLOUD = "1";
     
     # model config
     OLLAMA_CONTEXT_LENGTH = "60000";
     OLLAMA_NUM_PARALLEL = "1";
     # OLLAMA_KEEP_ALIVE = "30m";
     OLLAMA_KEEP_ALIVE = "-1";  # -1 = never unload

     
     # speed up with cache
     OLLAMA_KV_CACHE_TYPE="q4_0";  # NOTE: qwen models not as affected by q4 KV (allegedly)
     # OLLAMA_KV_CACHE_TYPE="f16";
    };
  };
}
