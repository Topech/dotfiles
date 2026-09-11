{ config, lib, pkgs, ... }:


{
  imports = [ ../llm-shared.nix ];


  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-rocm;

    modelsDir = config.llm.sharedModels.dir;
    # model = "${config.llm.sharedModelsDir}/current.gguf";

    # NOTE: NEXT RELEASE: you will config in an ini file.
    modelsPreset =  {
      "*" = {
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        flash-attn = "true";  # stops degradation using quantised cache
        ctx-size = 40000;
        n-gpu-layers = -1;
        models-max = 1;
      };

      "qwen3.8-27b-q3-unsloth" = {
        hf-repo = "unsloth/Qwen3.8-27B-GGUF";
        hf-file = "Qwen3.8-27B-UD-IQ3_XXS.gguf";
        ctx-size = 80000;
      };

      "qwen3.5-35b-a3b-q4-unsloth" = {
        hf-repo = "unsloth/Qwen3.5-35B-A3B-GGUF";
        hf-file = "Qwen3.5-35B-A3B-Q4_K_M.gguf";
        # MoE specifics
        n-gpu-layers = 999;  # 40 layers, offload all 'standard' layers to gpu
        n-cpu-moe = 15;  # offload some experts' layers to CPU. Increase if OOM (recommended 14)
      };

      "qwen3.6-35b-a3b-ud-q4-unsloth" = {
        hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF";
        hf-file = "Qwen3.6-35B-A3B-UD-Q4_K_M.gguf";
        # MoE specifics
        n-gpu-layers = 999;  # 40 layers, offload all 'standard' layers to gpu
        n-cpu-moe = 15;  # offload some experts' layers to CPU. Increase if OOM (recommended 14)
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
