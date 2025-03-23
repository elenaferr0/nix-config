{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./fzf.nix
    ./git.nix
    ./nvim
    ./python.nix
    ./ssh.nix
    ./yazi.nix
    ./zsh
  ];
  home.packages = with pkgs; [
    eza # Better ls
    fd # Better find
    httpie # Better curl
    jq # JSON pretty printer and manipulator
    ripgrep # Better grep

    alejandra # Nix formatter
    nixd # Nix LSP
    nixfmt-rfc-style
  ];
}
