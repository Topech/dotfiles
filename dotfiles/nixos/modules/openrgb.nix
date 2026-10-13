{ pkgs, ... }:

let
  openrgb_profile_file = "default.orp";
in {
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";    
    startupProfile = openrgb_profile_file;
  };

  environment.etc."OpenRGB/default.orp".text = ''
    [Profile]
    Name=Default
    Device=AsusMotherboard
    Mode=Static
    Color=130,0,255
  '';
}
