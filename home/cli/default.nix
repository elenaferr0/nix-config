{pkgs, ...}: {
  imports = [
    ./bat.nix
    # ./direnv.nix
    # ./fzf.nix
    # ./gh.nix
    ./git.nix
    ./nvim
    # ./gpg.nix
    # ./nix-index.nix
    # ./pfetch.nix
    ./ssh.nix
    ./zsh.nix
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
