{pkgs, ...}: {
  imports = [
    ./fish

    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    # ./nix-index.nix
    ./pfetch.nix
    ./ssh.nix
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
