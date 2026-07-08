{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    lmstudio
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    environmentVariables = {
     OLLAMA_CONTEXT_LENGTH = "40000";
     OLLAMA_KEEP_ALIVE = "-1";
    };
  };

}
