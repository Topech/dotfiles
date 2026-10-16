{ pkgs, ... }:

{
  # monitor gpu usage
  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
