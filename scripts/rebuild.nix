{pkgs, ...}:
pkgs.writeShellApplication {
  name = "rebuild";

  runtimeInputs = with pkgs; [
    git
    alejandra
    libnotify
  ];

  text = ''
    # Early return if no changes were detected (thanks @singiamtel!)
    if git diff --quiet '*.nix'; then
        echo "No changes detected, exiting."
        exit 0
    fi

    alejandra . &>/dev/null \
      || ( alejandra . ; echo "formatting failed!" && exit 1)

    # Print changes
    git add .
    echo "Rebuilding..."
    # shellcheck disable=SC2024
    sudo nixos-rebuild switch --flake ~/.config/nix-config &> nixos-switch.log || (grep --color error < nixos-switch.log && exit 1)

    current=$(nixos-rebuild list-generations | grep current)
    echo "NixOS Rebuild Successful $current"
  '';
}
