let
  #sources = import ./sources.nix;
  #pkgs = import sources.nixpkgs { };
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-24.05.tar.gz") {};
in

# See https://docs.haskellstack.org/en/stable/nix_integration/#using-a-custom-shellnix-file
{ ghc }:

pkgs.haskell.lib.buildStackProject {
  inherit ghc;
  name = "haskell-stack-nix";
  # System dependencies needed at compilation time
  buildInputs = [
    pkgs.zlib
    pkgs.xorg.libxcb
    pkgs.xorg.libXrender
    pkgs.xorg.libXrandr
    pkgs.xorg.libXScrnSaver
    pkgs.xorg.libXext
    pkgs.xorg.libXft
    pkgs.xorg.libXpm
    pkgs.haskellPackages.X11
  ];
}
