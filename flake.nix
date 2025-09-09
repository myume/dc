{
  description = "A flake for directory changes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.default = pkgs.rustPlatform.buildRustPackage {
        pname = "dc";
        version = "0.1.0";

        src = ./.;

        cargoLock = {
          lockFile = ./Cargo.lock;
        };

        postInstall = ''
          mkdir -p $out/share/dc
          substitute ${./dc.plugin.zsh} $out/share/dc/dc.plugin.zsh \
            --replace "EXECUTABLE_PATH" "$out/bin/dc"
        '';
      };

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          rustc
          cargo
        ];
      };
    });
}

