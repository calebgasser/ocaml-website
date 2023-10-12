{
  description = "My OCaml project";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ocaml-overlay.url = "github:nix-ocaml/nix-overlays";
    ocaml-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, flake-utils, ocaml-overlay }: 
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            ocaml-overlay.overlays.default
          ];
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.ocaml
            pkgs.ocamlPackages.dune_2
            pkgs.ocamlPackages.merlin
            pkgs.ocamlPackages.utop
            pkgs.ocamlPackages.dream
          ];
          shellHook = ''
            eval $(opam env)
          '';
        };
      }     
    );
}
