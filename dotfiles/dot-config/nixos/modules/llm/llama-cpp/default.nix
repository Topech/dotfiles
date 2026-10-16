{ config, lib, pkgs, ... }:


{
  imports = [ ../llm-shared.nix ];


  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-rocm;

    modelsDir = config.llm.sharedModels.dir;
    # model = "${config.llm.sharedModelsDir}/current.gguf";

    # NOTE: NEXT RELEASE: you will config in an ini file.
    modelsPreset = let
        _128k_tokens = 128 * 1024; 
        _100k_tokens = 100 * 1024;
        _80k_tokens = 80 * 1024;
        _60k_tokens = 60 * 1024;
        _40k_tokens = 40 * 1024;
        _1k_tokens = 1024;
      in {
        "*" = {
          # cache-type-k = "q8_0";
          # cache-type-v = "q8_0";
          cache-type-k = "f16";
          cache-type-v = "f16";
          flash-attn = "true";  # stops degradation using quantised cache
          ctx-size = _40k_tokens;
          n-gpu-layers = -1;
          models-max = 1;

          split-mode = "tensor";
          tensor-split = "1,1";

          ## NOTE: blows out RAM at large context models.
          # spec-type = "draft-mtp";
          # spec-draft-n-max = 2;
        };

        "qwen3.8-27b-q5xl-unsloth-with-draft" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          hf-file = "Qwen3.8-27B-UD-Q5_K_XL.gguf";
          ctx-size = 100 * _1k_tokens;

          spec-type = "draft-mtp";
          # tensor doesnt like mtp
          split-mode = "layer";
          # we can use quantised kv if not tensor split!
          cache-type-k = "q8_0";
          cache-type-v = "q8_0";
          spec-draft-n-max = 2; # 3 ~ 16-22 tok/sec
          parallel = 1;  # without this it crashes way more.
        };
        "qwen3.8-27b-q5-unsloth-with-draft" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          hf-file = "Qwen3.8-27B-UD-Q5_K_M.gguf";
          ctx-size = 120 * _1k_tokens;

          spec-type = "draft-mtp";
          # tensor doesnt like mtp
          split-mode = "layer";
          # we can use quantised kv if not tensor split!
          cache-type-k = "q8_0";
          cache-type-v = "q8_0";
          spec-draft-n-max = 2; # 3 ~ 16-22 tok/sec
          parallel = 1;  # without this it crashes way more.
        };

        "qwen3.8-27b-q4-unsloth-with-draft" = {
          alias = "default";
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          hf-file = "Qwen3.8-27B-UD-Q4_K_M.gguf";
          ctx-size = 120 * _1k_tokens;

          # spec-type = "draft-simple";
          # hf-repo-draft = "Qwen/Qwen3-1.7B-GGUF:Q8_0";
          # spec-draft-n-max = 4;

          spec-type = "draft-mtp";
          # tensor doesnt like mtp
          split-mode = "layer";
          # we can use quantised kv if not tensor split!
          cache-type-k = "q8_0";
          cache-type-v = "q8_0";
          spec-draft-n-max = 3;
          parallel = 1;  # without this it crashes way more.
        };

        "qwen3.8-27b-q3-unsloth" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          hf-file = "Qwen3.8-27B-UD-IQ3_XXS.gguf";
          ctx-size = _128k_tokens;
        };

        "qwen3.8-27b-q4-unsloth" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          hf-file = "Qwen3.8-27B-UD-Q4_K_M.gguf";
          ctx-size = _100k_tokens;
        };

        "qwen3.8-27b-q5-unsloth" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          hf-file = "Qwen3.8-27B-UD-Q5_K_M.gguf";
          ctx-size = _100k_tokens;
        };

        "qwen3.5-35b-a3b-q4-unsloth" = {
          hf-repo = "unsloth/Qwen3.5-35B-A3B-GGUF";
          hf-file = "Qwen3.5-35B-A3B-Q4_K_M.gguf";
          ctx-size = _80k_tokens;
          # MoE specifics
          split-mode = "layer";
          n-gpu-layers = 25;  # 40 layers, offload all 'standard' layers to gpu
          n-cpu-moe = 15;  # offload some experts' layers to CPU. Increase if OOM (recommended 14)
        };

        "qwen3.6-35b-a3b-ud-q4-unsloth" = {
          hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF";
          hf-file = "Qwen3.6-35B-A3B-UD-Q4_K_M.gguf";
          ctx-size = _80k_tokens;
          # MoE specifics
          split-mode = "layer";
          n-gpu-layers = 25;  # 40 layers, offload all 'standard' layers to gpu
          n-cpu-moe = 15;  # offload some experts' layers to CPU. Increase if OOM (recommended 14)
        };
      };


    host = "0.0.0.0";
    port = 8080;
    openFirewall = true; 
    
    extraFlags = [
      "--metrics"
      # "--verbose"
      "--ctx-checkpoints" "16"  # bug with tensor split causes crash at high ctx lengths
    ];
  };


  # NOTE: this gives the service access to the shared models
  systemd.services.llama-cpp.serviceConfig = {
    EnvironmentFile = "${config.llm.secretsDir}/.env";

    SupplementaryGroups = [ 
      config.llm.sharedModels.group 
    ];
  };
}
