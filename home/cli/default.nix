{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./fzf.nix
    ./git.nix
    ./nvim
    ./python.nix
    ./ssh.nix
    ./zsh
  ];
  home.packages = with pkgs; [
    eza # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    jq # JSON pretty printer and manipulator

    nixd # Nix LSP
    alejandra # Nix formatter
    nixfmt-rfc-style
  ];
}
