{ pkgs, ... }:

{
  imports = [
    ../modules/boot.nix
    ../modules/locale-aus-perth.nix
    ../modules/networking.nix
    ../modules/keyboard.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    vim
    git
    delta
    htop
    jq
    tmux
    rustc
    cargo
    stow
    tree-sitter
  ];

  programs.neovim.enable = true;
  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;
}
