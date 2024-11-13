let
  # sources = import ./src/nix/sources.nix;
  # pkgs = import sources.nixpkgs { };
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-24.05.tar.gz") {};
in
pkgs.mkShell {
  buildInputs = [ pkgs.stack ];
  # Note that Stack relies on the `NIX_PATH` environment variable to discover
  # the `nixpkgs` and obtain the right `ghc`.
  NIX_PATH = "nixpkgs=" + pkgs.path;
}
