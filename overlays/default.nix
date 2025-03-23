{pkgs ? import <nixpkgs> {}, ...}: rec {
  yazi = pkgs.callPackage ./yazi {};
}
