{
  description = "RopwareJB Xmonad";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    self.submodules = true;
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        haskellPackages = pkgs.haskellPackages;

        jailbreakUnbreak = pkg:
          pkgs.haskell.lib.doJailbreak (pkg.overrideAttrs (_: { meta = { }; }));
      in
      {
        packages = {
          xmonad =
            haskellPackages.callCabal2nix "xmonad" self rec {
              # Dependency overrides go here
            };
          xmobar =
            haskellPackages.callCabal2nix "xmobar" self rec {
              # Dependency overrides go here
            };
          default = self.packages.${system}.xmonad;
        };

        # defaultPackage = self.packages.${system}.default;

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            haskellPackages.haskell-language-server # you must build it with your ghc to work
            ghcid
            gnumake
            cabal-install
            stack
          ];
          inputsFrom = map (__getAttr "env") (__attrValues self.packages.${system});
        };
        devShell = self.devShells.${system}.default;
        overlays.default = final: prev: {
          xmobar-ropware = self.packages.xmobar;
          xmonad-ropware = self.packages.xmonad;
        };
      }
    );
}
