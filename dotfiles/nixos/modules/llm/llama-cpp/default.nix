{ config, lib, pkgs, ... }:


{
  imports = [ ../llm-shared.nix ];


  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-vulkan;    

    modelsDir = config.llm.sharedModels.dir;
    # model = "${config.llm.sharedModelsDir}/current.gguf";
    # NOTE: NEXT RELEASE: you will config in an ini file.
    modelsPreset =  {
      "*" = {
        "ctx-size" = 40000;
        "n-gpu-layers" = -1;
        "models-max" = 1;
      };

      "qwen3.8-27b-q3-unsloth" = {
        "hf-repo" = "unsloth/Qwen3.8-27B-GGUF";
        "hf-file" = "Qwen3.8-27B-UD-IQ3_XXS.gguf";
      };

      "qwen3.5-35b-a3b-q4" = {
        "hf-repo" = "Qwen/Qwen3.5-35B-A3B-Instruct-GGUF";
        "hf-file" = "Qwen3.5-35B-A3B-Instruct-Q4_K_M.gguf";
        "n-gpu-layers" = 10;  # ~ 25% gpu, 10/40 layers
      };
    };

    host = "127.0.0.1";
    port = 8080;

 
    extraFlags = [ ];
  };


  # NOTE: this gives the service access to the shared models
  systemd.services.llama-cpp.serviceConfig = {
    EnvironmentFile = "${config.llm.secretsDir}/.env";

    SupplementaryGroups = [ 
      config.llm.sharedModels.group 
    ];
  };
}
